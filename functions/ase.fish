function __ase_set_env_from_section -d 'Parse the section section_name from file available in file_path' -a 'section_name' 'file_path'
    # section_name must be a regular expression to make sure the best possible match
    # Get all the lines after the regex of section_name
    set -x lines (grep -A -1 -E "$section_name" $file_path)
    # echo $lines

    for line in $lines[2..-1]
        # The grep will return 0 when match
        string match -r '^ *\[.*\] *$' $line > /dev/null
        if test $status -eq 0
            # Beginning of new section
            break
        end

        # Parse the line and set envrionment variables
        # echo $line
        set -x env_name (string match -r '^ *[^=]+ *' $line | xargs | tr /a-z/ /A-Z/)
        set -x env_val (string match -r ' *[^=]+ *$' $line 2> /dev/null | xargs)


        if [ "$env_name" != "" ]
            if [ $env_name = "REGION" ]
                # Special case for the region in the ~/.aws/config file
                set -x env_name 'AWS_DEFAULT_REGION'
            end

            # Print this something beautiful
            echo -n "Setting "
            set_color blue; echo -n $env_name; set_color normal
            echo -n " to "
            set_color red; echo -n "WAIT A SECOND, WHY SHOULD I PRINT THIS OUT AGAIN?"; set_color normal
            echo

            set -xg $env_name $env_val
        end
    end
end

function ase -d 'Set up AWS key environment variable to override the profile variable' -a aws_profile
    set -x CONFIG_FILE ~/.aws/config
    set -x CREDENTIAL_FILE ~/.aws/credentials

    if test -n "$aws_profile"
        if grep -Eo "\[(profile)? *$aws_profile\]" $CONFIG_FILE > /dev/null
            # Set the env from config file
            __ase_set_env_from_section  "\[(profile )?$aws_profile\]" $CONFIG_FILE
            __ase_set_env_from_section  "\[$aws_profile ?\]" $CREDENTIAL_FILE
        else
            echo "Could NOT find profile $aws_profile in config file ($CONFIG_FILE). No profile set"
        end
    end
end
