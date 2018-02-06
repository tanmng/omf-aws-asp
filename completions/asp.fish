function __fish_print_aws_profiles -d 'Print a list of AWS profiles' -a 'select'
    set -x CONFIG_FILE ~/.aws/config
    set -x CREDENTIAL_FILE ~/.aws/credentials

    command sed -n 's/^\[(?profile )?\(.*\)\]/\1/p' $CONFIG_FILE
end

complete --command asp --no-files --arguments '(__fish_print_aws_profiles)'
complete --command ase --no-files --arguments '(__fish_print_aws_profiles)'
