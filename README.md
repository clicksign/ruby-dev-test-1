## The steps to start the project

- Prepare Database
  ```sh
  rails db:drop db:create db:migrate
  ```

- Start Server
  ```sh
  rails s
  ```

## Usage
### Creating Folder one by one

```sh
# In Rails Console
params = { name: 'Areas da Empresa' }
simple_folder = Folder.create(params)
simple_folder.name # => 'Areas da Empresa'

sub_folder = simple_folder.sub_folders.build(name: 'Financeiro')
sub_folder.save
sub_folder.name # => 'Financeiro'
```

### Creating more then one Folder

```sh
# In Rails Console
params = {
  name: 'Level 0',
  sub_folders_attributes: [
    {
      name: 'Level 1',
      sub_folders_attributes: [
        {
          name: 'Level 2',
          sub_folders_attributes: [
            { name: 'Level 3' }
          ]
        }
      ]
    }
  ]
}

Folder.create!(params) # => Insert 4 Folder
Folder.find_by(name: 'Level 3').full_path # => 'Level 0/Level 1/Level 2/Level 3

```