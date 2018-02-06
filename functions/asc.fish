function asc -d 'Clear all environment variables related to AWS'
    set -x all_aws_related_env (env | grep -Eo "AWS_[^=]+")

    # Count will return 1 if the list is empty
    if count $all_aws_related_env > /dev/null
        for env_value in $all_aws_related_env
            echo Clearing $env_value
            set -e $env_value
        end
    else
        echo No environment variable with the pattern "AWS_[^=]+" found
    end
end
