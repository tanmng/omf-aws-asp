function asp -d 'Switches AWS profile' -a 'aws_profile'
  if test -n "$aws_profile"
    if fgrep -q "[profile $aws_profile]" ~/.aws/config
      set -gx AWS_DEFAULT_PROFILE $aws_profile
    else
      echo "Could NOT find profile $aws_profile in config file. No profile set"
    end
  end
end
