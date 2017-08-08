# # encoding: utf-8

# Inspec test for recipe test::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

unless os.windows?
  # This is an example test, replace with your own test.
 describe user('cloud_user'), :skip do
    it { should exist }
  end
end

# This is an example test, replace it with your own test.
#describe port(80), :skip do
#  it { should_not be_listening }
#end
#
#
if os[:family] == 'redhat'

 describe package('git') do
  it { should be_installed }	
 end

 describe package('python-pip') do
  it { should be_installed}
 end
 
 describe package('docker') do
  it { should be_installed }
 end 

 describe service('docker') do
  it {should be_running }
 end




end