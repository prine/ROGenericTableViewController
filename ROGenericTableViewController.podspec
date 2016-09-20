#
# Be sure to run `pod lib lint ROGenericTableViewController.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |spec|
    spec.name         = 'ROGenericTableViewController'
    spec.version      = '2.1.0'
    spec.license      = { :type => 'MIT' }
    spec.homepage     = 'https://gitlab.com/rascor-apps/ROGenericTableViewController'
    spec.authors      = { 'Robin Oster' => 'prine.dev@gmail.com' }
    spec.summary      = 'A generic TableViewController class which is able to deal with custom created objects very easily'
    spec.source       = { :git => 'https://gitlab.com/rascor-apps/ROGenericTableViewController.git', :tag => "2.1.0" }
    spec.source_files = 'Source/**/*'
    spec.framework    = 'SystemConfiguration'
    spec.ios.deployment_target  = '9.3'
end
