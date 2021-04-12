# Directories

- [Creating a directory](#creating-a-directory)
- [Updating a directory](#updating-a-directory)
- [Deleting a directory](#deleting-a-directory)

## Listing all directories with files

- perform a GET request to `/api/v1/directories`

## Creating a directory

- perform a POST request to `/api/v1/directories` with params:
  - param: `name` is required
  - param: `parent_id` is optional, directory must exists

```
params: {
  directory: {
    name: "Directory Name",
    parent_id: "5"
  }
}
```

If you send parent_id param and directory is not found, it will return a 404 with error

## Updating a directory

- perform a PUT request to `/api/v1/directories/<directory_id>`
  - param: `name` is required
  - param: `parent_id` is optional

```
params: {
  directory: {
    name: "New directory name",
    parent_id: "<new_parent_id>"
  }
}
```


## Deleting a directory

- perform a DELETE request to `/api/v1/directories/<directory_id>`
