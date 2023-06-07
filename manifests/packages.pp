# @summary
#
# @param package_list [Hash]
#   Define a hash of packages and manage attributes
#   
# @example Using Puppet resource syntax
#   class { "delegate_module::packages":
#     package_list = {
#       jq => {
#         ensure => 1.6.0
#       }
#     }
#   }
#
# @example Use Hiera APL 
#   include "delegate_module::packages"
#
#   data/common.yaml 
#   ---
#   # Specify package_list using hiera hash syntax
#   delegate_module::packages::package_list:
#     jq:
#       ensure: 1.6.0
#
#
class delegate_module::packages (
  Hash $package_list = {},
) {
  $package_list.each | String $package, Hash $package_opts | {
    package {
      default:
        ensure => present,
        ;
      $package:
        * => pick($package_opts,{}),
    }
  }
}
