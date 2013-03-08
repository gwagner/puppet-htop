class htop
{
    include repo_epel

    package {
        #packages require a repo
        'htop':
            ensure => 'installed',
            provider => 'yum',
            require => Yumrepo['epel'];
    }

    file {
        'htop-config-path':
            mode => 700,
            owner => "root",
            group => "root",
            path => ["/root/.config/", "/root/.config/htop/"],
            recurse => true,
            ensure => 'directory';

        'htop-config':
            mode => 664,
            owner => "root",
            group => "root",
            path => "/root/.config/htop/htoprc",
            source => "puppet:///modules/htop/htop-config",
            require => [
                Package["htop"],
                File['htop-config-path']
            ];
    }
}
