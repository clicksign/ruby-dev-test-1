# AWS Files Manager

AWS Files Manager is a Rails application for managing files stored on Amazon S3. It allows you to create directories, upload files, and view, download, and delete existing files.

## Setup
Make sure you have Ruby on Rails installed on your system.

### Installing using Docker
Run the following command to install the project dependencies:

Inside folder Run to build the project

```bash
docker compose build
```

### Database configuration
Make sure you have correctly configured the database information in the `config/data_base.yml` file.

Build the application
```bash
docker compose up --build
```

```bash
docker compose run web rake db:create db:migrate
```

The project will be accessible at `http://localhost:3000`.

## Usage
Start the application
```bash
docker compose up
```
Stop the application
```bash
docker compose down
```

### Installing without Docker
Run the following command to install the project dependencies:

Inside folder Run to build the project

```bash
bundle install
```

```bash
rake db:create db:migrate
```

```bash
bundle exec rails s -p 3000 -b 0.0.0.0
```

## Usage

The AWS Files Manager application provides the following features:

- **Directories**: You can create directories to organize your files. Directories can have a hierarchical structure using the `has_ancestry` feature.
- **File Upload**: You can upload files to a specific directory. The files will be stored on Amazon S3 and in the local dasebase.
- **File Viewing**: You can view the existing files in a specific directory. The files are displayed in a list with their names and options to download and delete.
- **File Download**: You can download a specific file from Amazon S3 using a generated download URL.
- **File Deletion**: You can delete a specific file from the directory and Amazon S3.


## Observations about developing
- Opted for PostgreSQL as the database since I have more experience with it, and used Docker to compose my development environment.
- Chose to use a lightweight gem called Ancestry for managing the hierarchical structure of directories since I have used it before and it fits well in this scenario.
- Created a model for directories and subdirectories solely to maintain the hierarchy of directories using the Ancestry gem.
- The primary focus of the application is on AWS Files. They store the URLs, paths, and handle the creation of directories and files in S3. If a directory already exists in S3, it will not be duplicated, and only the necessary files will be saved.
- Implemented tests for controllers and models. Testing the S3 functionality itself is not necessary as it is handled by the AWS SDK.


>  This is a challenge by [Clicksign](https://www.clicksign.com/)
