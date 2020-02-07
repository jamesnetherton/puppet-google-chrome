require 'spec_helper'

describe 'google_chrome' do

  context 'with Debian osfamily' do
    let :facts do
      {
        :os => { :family => 'Debian', :name => 'Debian', :release => { :major => '9', :full => '0' }},
        :osfamily      => 'Debian',
        :lsbdistid     => 'Debian',
        :puppetversion => Puppet.version,
      }
    end

    it do
      should contain_class('google_chrome::config')
      should contain_class('google_chrome::install')
      should contain_file('/etc/default/google-chrome').with(
        :ensure  => 'present',
        :owner   => 'root',
        :group   => 'root',
        :mode    => '0644',
        :content => "repo_add_once=\"false\"\nrepo_reenable_on_distupgrade=\"true\"\n",
      )
      should contain_apt__source('google-chrome').with(
        :location => '[arch=amd64] http://dl.google.com/linux/chrome/deb/',
        :release  => 'stable',
        :key      => {
          'ensure' => 'absent',
          'id'     => '4CCA1EAF950CEE4AB83976DCA040830F7FAC5991',
          'source' => 'https://dl.google.com/linux/linux_signing_key.pub',
        },
        :repos    => 'main',
        :include  => {
          'src' => false
        }
      )
      should contain_archive('/etc/apt/trusted.gpg.d/google-chrome.asc')

      should contain_package('google-chrome-stable').with(
        :ensure => 'installed',
      )
     end
  end

  context 'does not support RHEL 6' do
    let :facts do
      {
        :osfamily                  => 'RedHat',
        :operatingsystemmajrelease => 6,
      }
    end

    it 'should fail' do
      expect { should compile }.to raise_error(/Operating system not supported/)
    end
  end

  context 'with RedHat osfamily' do
    let :facts do
      {
        :osfamily                  => 'RedHat',
        :operatingsystem           => 'Fedora',
        :lsbdistid                 => 'Fedora',
        :operatingsystemmajrelease => 24,
      }
    end

    it do
      should contain_class('google_chrome::config')
      should contain_class('google_chrome::install')
      should contain_file('/etc/default/google-chrome').with(
        :ensure  => 'present',
        :owner   => 'root',
        :group   => 'root',
        :mode    => '0644',
        :content => "repo_add_once=\"false\"\nrepo_reenable_on_distupgrade=\"true\"\n",
      )
      should contain_yumrepo('google-chrome').with(
        :name     => 'google-chrome',
        :descr    => 'google-chrome',
        :enabled  => 1,
        :gpgcheck => 1,
        :baseurl  => 'https://dl.google.com/linux/chrome/rpm/stable/x86_64',
        :gpgkey   => 'https://dl.google.com/linux/linux_signing_key.pub',
      )
      should contain_package('google-chrome-stable').with(
        :ensure => 'installed',
      )
    end
  end

  context 'with Suse osfamily' do
    let :facts do
      {
        :osfamily        => 'Suse',
        :operatingsystem => 'OpenSuse',
        :lsbdistid       => 'OpenSuse',
      }
    end

    it do
      should contain_class('google_chrome::config')
      should contain_class('google_chrome::install')
      should contain_file('/etc/default/google-chrome').with(
        :ensure  => 'present',
        :owner   => 'root',
        :group   => 'root',
        :mode    => '0644',
        :content => "repo_add_once=\"false\"\nrepo_reenable_on_distupgrade=\"true\"\n",
      )
      should contain_zypprepo('google-chrome').with(
        :name     => 'google-chrome',
        :baseurl  => 'https://dl.google.com/linux/chrome/rpm/stable/x86_64',
        :enabled  => 1,
        :gpgcheck => 0,
        :type     => 'rpm-md',
      )
      should contain_package('google-chrome-stable').with(
        :ensure => 'installed',
      )
    end
  end

  context 'with Debain osfamily all parameters overridden' do
    let :facts do
      {
        :os => { :family => 'Debian', :name => 'Debian', :release => { :major => '9', :full => '0' }},
        :osfamily      => 'Debian',
        :lsbdistid     => 'Debian',
        :puppetversion => Puppet.version,
      }
    end

    let :params do
      {
        :version                => 'unstable',
        :package_name           => 'fake-google-chrome',
        :repo_gpg_key           => 'http://test.org/gpg.key',
        :repo_gpg_key_id        => '0AAA0AAF000AAA0AA00000AAA000000A0AAA0000',
        :repo_name              => 'fake-google-chrome',
        :defaults_file          => '/etc/default/fake-google-chrome',
        :defaults_proxy_pac_url => 'http://test.org/proxy.pac'
      }
    end

    it do
      should contain_class('google_chrome::config')
      should contain_class('google_chrome::install')
      should contain_file('/etc/default/fake-google-chrome').with(
        :ensure => 'present',
        :owner   => 'root',
        :group   => 'root',
        :mode    => '0644',
        :content => "repo_add_once=\"false\"\nrepo_reenable_on_distupgrade=\"true\"\nproxy-pac-url=\"http://test.org/proxy.pac\"\n",
      )
      should contain_apt__source('fake-google-chrome').with(
        :location => '[arch=amd64] http://dl.google.com/linux/chrome/deb/',
        :release  => 'stable',
        :key      => {
          'ensure' => 'absent',
          'id'     => '0AAA0AAF000AAA0AA00000AAA000000A0AAA0000',
          'source' => 'http://test.org/gpg.key',
        },
        :repos    => 'main',
        :include  => {
          'src' => false
        }
      )
      should contain_archive('/etc/apt/trusted.gpg.d/fake-google-chrome.asc')
      should contain_package('fake-google-chrome-unstable').with(
        :ensure => 'installed',
      )
    end
  end

  context 'with RedHat osfamily all parameters overridden' do
    let :facts do
      {
        :osfamily                  => 'RedHat',
        :operatingsystem           => 'Fedora',
        :lsbdistid                 => 'Fedora',
        :operatingsystemmajrelease => 24,
      }
    end

    let :params do
      {
        :version                => 'unstable',
        :package_name           => 'fake-google-chrome',
        :repo_gpg_key           => 'http://test.org/gpg.key',
        :repo_name              => 'fake-google-chrome',
        :defaults_file          => '/etc/default/fake-google-chrome',
        :defaults_proxy_pac_url => 'http://test.org/proxy.pac'
      }
    end

    it do
      should contain_class('google_chrome::config')
      should contain_class('google_chrome::install')
      should contain_file('/etc/default/fake-google-chrome').with(
        :ensure => 'present',
        :owner   => 'root',
        :group   => 'root',
        :mode    => '0644',
        :content => "repo_add_once=\"false\"\nrepo_reenable_on_distupgrade=\"true\"\nproxy-pac-url=\"http://test.org/proxy.pac\"\n",
      )
      should contain_yumrepo('fake-google-chrome').with(
        :name     => 'fake-google-chrome',
        :descr    => 'fake-google-chrome',
        :enabled  => 1,
        :gpgcheck => 1,
        :baseurl  => 'https://dl.google.com/linux/chrome/rpm/stable/x86_64',
        :gpgkey   => 'http://test.org/gpg.key',
      )
      should contain_package('fake-google-chrome-unstable').with(
        :ensure => 'installed',
      )
    end
  end

  context 'with Suse osfamily all parameters overridden' do
    let :facts do
      {
        :osfamily        => 'Suse',
        :operatingsystem => 'OpenSuse',
        :lsbdistid       => 'OpenSuse',
      }
    end

    let :params do
      {
        :version                => 'unstable',
        :package_name           => 'fake-google-chrome',
        :repo_gpg_key           => 'http://test.org/gpg.key',
        :repo_name              => 'fake-google-chrome',
        :defaults_file          => '/etc/default/fake-google-chrome',
        :defaults_proxy_pac_url => 'http://test.org/proxy.pac'
      }
    end

    it do
      should contain_class('google_chrome::config')
      should contain_class('google_chrome::install')
      should contain_file('/etc/default/fake-google-chrome').with(
        :ensure => 'present',
        :owner   => 'root',
        :group   => 'root',
        :mode    => '0644',
        :content => "repo_add_once=\"false\"\nrepo_reenable_on_distupgrade=\"true\"\nproxy-pac-url=\"http://test.org/proxy.pac\"\n",
      )
      should contain_zypprepo('fake-google-chrome').with(
        :name     => 'fake-google-chrome',
        :baseurl  => 'https://dl.google.com/linux/chrome/rpm/stable/x86_64',
        :enabled  => 1,
        :gpgcheck => 0,
        :type     => 'rpm-md',
      )
      should contain_package('fake-google-chrome-unstable').with(
        :ensure => 'installed',
      )
    end
  end

  context 'with invalid osfamily' do
    let :facts do
      {
        :osfamily => 'Darwin',
      }
    end

    it 'should fail' do
      expect { should compile }.to raise_error(/Unsupported operating system family/)
    end
  end

  context 'with invalid chrome version' do
    let :facts do
      {
        :osfamily => 'Debian',
      }
    end

    let :params do
      {
        :version => 'test-version',
      }
    end

    it 'should fail' do
      expect { should compile }.to raise_error(/does not match/)
    end
  end  
end
