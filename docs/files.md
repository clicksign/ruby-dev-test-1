# Files

- [Show files from a directory](#show-files-from-a-directory)
- [Upload a file](#upload-a-file)
- [Delete a file](#delete-a-file)

## Show files from a directory

- perform a GET request to `/api/v1/directories/<directory_id>/files`

## Upload a file

- perform a POST request to `/api/v1/directories/<directory_id>/files`
  - param: `file[]` is array and required
  - the content-type for the form must be type of `multipart`
  - you can upload multiple files at once

```
{
  file[]: <selected_file_for_upload_1.ext>,
  file[]: <selected_file_for_upload_2.ext>,
}
```

## Delete a file

- perform a DELETE request to `/api/v1/directories/<directory_id>/files/<file_id>`
  - the `id` of the file can be retrieved from [Show files from a directory](#show-files-from-a-directory)

## Get a file direct path

- perform a GET request to `/api/v1/directories/<directory_id>/files/<file_id>`
  - the `id` of the file can be retrieved from [Show files from a directory](#show-files-from-a-directory)
