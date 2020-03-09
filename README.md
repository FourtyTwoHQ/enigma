# Enigma

Enigma is a Ruby gem that fetches your application's passwords from AWS Secrets Manager and builds a file containing them using a `Templatefile` as the guide. This results in a simple and platform-agnostic approach to rendering your application password in to a compilable file.

## Installation

`gem install enigma-gen`

## Usage

Once the gem is installed, simply running `enigma exec` is enough to get you started. However, should you want to pass in specific command line options instead of specifying values in your `Enigmafile`, you can do that as well.

```
--access_key_id [String] Your AWS Access Key ID
```
```
--secret_access_key [String] Your AWS Secret Access Key
```
```
--aws_region [String] Your AWS Region
```
```
--environment [String] Your specified secret environment
```
```
--config [String] Path to your Enigmafile
```

**Note**: Parameters passed in via CLI take precedence over those listed in your `Enigmafile`.

## Enigmafile

The Enigmafile is used to tell Enigma what to do. It is a YAML file with a basic structure and contains the following properties:

1. **access_key_id**  
  The environment variable that your `AWS_ACCESS_KEY_ID` is associated with. Do **not** commit your actual access key ID to the Enigmafile
2. **secret_access_key**  
  The environment variable that your `AWS_SECRET_ACCESS_KEY` is associated with. Do **not** commit your actual secret access key to the Enigmafile
3. **aws_region**  
  The AWS region that your Secrets Manager instance is in. Eg: `us-east-2`
4. **template_path**  
  The relative path from the project root to the file containing your template
5. **output_path**  
  The relative path from the project root to the desired location of the file containing your application's passwords
6. **environment**  
  Optional. If you've given your passwords an environment in Secrets Manager, add the environment here. Eg: `prod/someProvider`, enter `prod`. This will prefix **all** searches in Secrets Manager with the environment value and a trailing slash.
7. **secrets**  
  An array of secrets from Secrets Manager, and the item mapping for your template

As an example, an `Enigmafile` could similar to this:

```yml
access_key_id: MY_AWS_KEY_ENV_VAR
secret_access_key: MY_AWS_SECRET_ENV_VAR
aws_region: us-east-2
template_path: .enigma/Templatefile
output_path: Keys.swift
environment: prod
secrets:
- name: ProviderA
  items:
  - key: apiKey
    property_name: apiKey
  - key: apiSecret
    property_name: apiSecret
- name: ProviderB
  items:
  - key: some.longer.key.from.aws.secretmanager.password
    property_name: password
```

For more information about the `secrets` portion of the `Enigmafile`, see below.

## Templatefile

The Templatefile contains your template rendering code, written in Ruby, and is customizable however you want, as long as it remains valid syntax for use with `ERB`.

As an example, a `Templatefile` could look similar to this if we were adding secrets to a Swift application:

```ruby
enum Keys {
    <% @secrets.each do |secret| %>
        enum <%= secret.name %> {
            <% secret.items.each do |item| %>
                static let <%= item.property_name %> = <%= item.value %>
            <% end %>
        }
    <% end %>
}
```

This very simple template could translate to

```swift
enum Keys {
    enum ProviderA {
        static let apiKey = "someApiKeyForProviderA"
        static let apiSecret = "someApiSecretForProviderA"
    }
    enum ProviderB {
        static let password = "somePasswordForProviderB"
    }
}
```

## Secret Mapping

AWS Secrets Manager allows users to combine multiple key-value pairs under a single `secret name`. For example, in Secrets Manager you could create the following (*schema for information purposes only*):

```
{
  secret_name: "prod/ProviderA"
  secret_values: [
    {
      "key": "apiKey",
      "value": "s0m3R3@a1LySt120nG@P1K3y!"
    },
    {
      "key": "apiSecret",
      "value": "s0m3R3@a1LySt120nG$3cR37!"
    }
  ]
}
```

In the `Enigmafile` we would use the `secret_name` as the parent secret name, and the individual `secret_values` would be `item`s for that `secret`. As an example, the above would translate to the following `Enigmafile` format:

```yml
environment: prod
secrets:
- name: ProviderA
  items:
  - key: apiKey
    property_name: apiKey
  - key: apiSecret
    property_name: apiSecret
```

The `property_name` attribute of the `item` only pertains to how the item is rendered in the template. Specifically, it is the name of the property that will be used to hold the secret value. You can give the `property_name` attribute any value you would like.

**Remember**: try to prefix all of your secrets with your environment in  Secrets Manager, and use the `environment` attribute of the `Enigmafile` / CLI param to automatically append the `environment` to every secret fetch.
