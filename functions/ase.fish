function __ase_set_env_from_section -d 'Parse the section section_name from file available in file_path' -a 'section_name' 'file_path'
    # section_name must be a regular expression to make sure the best possible match
    # Get all the lines after the regex of section_name

    ## grep -A -1(specifically the -1) was causing issues so I modified it - Syntax issue I believe
    ##
    ## Example:    
    ##
    ## cat ~/.aws/config                                                       
    ##   [profile ane_terra]
    ##   region = us-west-2
    ## 
    ##   [profile audit]
    ##   region = us-east-1
    ## 
    ## ase audit
    ##   grep: -1: invalid context length argument
    ##
    ##  I also added a string check to treat the creds file and config file differently
    if string match -q -- "*credentials" $file_path
        ##  This will get more lines for the credentials portion as well as its a fixed string
        ##  which is put in to not get my default lines.(could also do an exclude with the grep)
        set -x lines (grep -A3 -Fx "$section_name" $file_path)
    else
        set -x lines (grep -A1 -E "$section_name" $file_path)
    end

    # echo $lines

    for line in $lines[2..-1]
        # The grep will return 0 when match
        if echo $line | grep -E '^ *\[.*\] *$' > /dev/null
            # Beginning of new section
            break
        end

        # Parse the line and set envrionment variables
        # echo $line
        set -x env_name (echo $line | grep -Eo '^ *[^=]+ *' | xargs | tr /a-z/ /A-Z/)
        set -x env_val (echo $line | grep -Eo ' *[^=]+ *$' | xargs)

        if [ $env_name = "REGION" ]
            # Special case for the region in the ~/.aws/config file
            set -x env_name 'AWS_DEFAULT_REGION'
        end

        echo "Setting $env_name to WAIT A SECOND, WHY SHOULD I PRINT THIS OUT AGAIN?"

        set -xg $env_name $env_val
    end
end

function ase -d 'Set up AWS key environment variable to override the profile variable' -a aws_profile
    set -x CONFIG_FILE ~/.aws/config
    set -x CREDENTIAL_FILE ~/.aws/credentials

    if test -n "$aws_profile"
        if grep -Eo "\[(profile)? *$aws_profile\]" $CONFIG_FILE > /dev/null
            # Set the env from config file
            __ase_set_env_from_section  "\[(profile )?$aws_profile\]" $CONFIG_FILE
            ##  This is changed to have a more specific match for my credentials file to not hit the default
            __ase_set_env_from_section "[$aws_profile]" $CREDENTIAL_FILE
        else
            echo "Could NOT find profile $aws_profile in config file ($CONFIG_FILE). No profile set"
        end
    end
end
