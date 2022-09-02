# Ruby Dev Test 1
## _Projeto desenvolvido em Ruby on Rails APi Only_

Sistema de criação de diretórios e sub-diretórios, bem como upload de arquivos com persistência no serviço AWS S3. 
## Ruby
```sh
ruby 3.1.2
```
## Rails
```sh
Rails 7.0.3.1
```
## Configuração
```sh
1 - bundle install
```
```sh
2 - rake db:create
```
```sh
3 - rake db:migrate
```
## Suite de testes
```sh
rspec
```
## Endpoints
O header **acccept application/vnd.api+json** deve ser enviado em todas as requisições.
### Pastas
**Criando uma pasta**
 
```sh
[POST] Create
/v1/folders
{
  "data": {
    "type": "folders",
    "attributes": {
      "name": "nova-pasta4",
      "parent_id": 5 (opcional)
    }
  }
}
```
**Exemplo de retorno**
```sh
{
    "data": {
        "id": "48",
        "type": "folders",
        "attributes": {
            "name": "nova-pasta1"
        },
        "relationships": {
            "parent": {
                "data": null,
                "links": {
                    "related": "http://localhost:3000/v1/folders/48/parent"
                }
            },
            "sub-folders": {
                "data": [],
                "links": {
                    "related": "http://localhost:3000/v1/folders/48/sub_folders"
                }
            },
            "uploads": {
                "data": [],
                "links": {
                    "related": "http://localhost:3000/v1/folders/48/uploads"
                }
            }
        },
        "links": {
            "self": "http://localhost:3000/v1/folders/48"
        }
    }
}
```

**Atualizando uma pasta**
 
```sh
[PATCH] Update
/v1/folders/:id
{
    "data": {           
        "id": 39,
        "type": "folders",
        "attributes": {                
            "name": "new-folder-06f8"
        }
    }
}
```
**Exemplo de retorno**
```sh
{
    "data": {
        "id": "8",
        "type": "folders",
        "attributes": {
            "name": "new-folder-06f8"
        },
        "relationships": {
            "parent": {
                "data": null,
                "links": {
                    "related": "http://localhost:3000/v1/folders/8/parent"
                }
            },
            "sub-folders": {
                "data": [],
                "links": {
                    "related": "http://localhost:3000/v1/folders/8/sub_folders"
                }
            },
            "uploads": {
                "data": [],
                "links": {
                    "related": "http://localhost:3000/v1/folders/8/uploads"
                }
            }
        },
        "links": {
            "self": "http://localhost:3000/v1/folders/8"
        }
    }
}
```
**Mostrando uma pasta**
 
```sh
[GET] Get
/v1/folders/:id
```
**Exemplo de retorno**
```sh
{
    "data": {
        "id": "39",
        "type": "folders",
        "attributes": {
            "name": "new-folder-068"
        },
        "relationships": {
            "parent": {
                "data": {
                    "id": "5",
                    "type": "folders"
                },
                "links": {
                    "related": "http://localhost:3000/v1/folders/39/parent"
                }
            },
            "sub-folders": {
                "data": [],
                "links": {
                    "related": "http://localhost:3000/v1/folders/39/sub_folders"
                }
            },
            "uploads": {
                "data": [
                    {
                        "id": "4",
                        "type": "uploads"
                    },
                    {
                        "id": "6",
                        "type": "uploads"
                    },
                    {
                        "id": "7",
                        "type": "uploads"
                    },
                    {
                        "id": "8",
                        "type": "uploads"
                    },
                    {
                        "id": "9",
                        "type": "uploads"
                    },
                    {
                        "id": "10",
                        "type": "uploads"
                    },
                    {
                        "id": "11",
                        "type": "uploads"
                    },
                    {
                        "id": "12",
                        "type": "uploads"
                    },
                    {
                        "id": "13",
                        "type": "uploads"
                    }
                ],
                "links": {
                    "related": "http://localhost:3000/v1/folders/39/uploads"
                }
            }
        },
        "links": {
            "self": "http://localhost:3000/v1/folders/39"
        }
    }
}
```
**Deletando uma pasta**
 
```sh
[DELETE] Delete
/v1/folders/:id
```
**Listando todas as pastas**
 
```sh
[GET] Index
/v1/folders?q[name_i_cont]=new
```
**Exemplo de retorno**
```sh
{
    "data": [
        {
            "id": "1",
            "type": "folders",
            "attributes": {
                "name": "new-folder-02"
            },
            "relationships": {
                "parent": {
                    "data": null,
                    "links": {
                        "related": "http://localhost:3000/v1/folders/1/parent"
                    }
                },
                "sub-folders": {
                    "data": [
                        {
                            "id": "2",
                            "type": "folders"
                        }
                    ],
                    "links": {
                        "related": "http://localhost:3000/v1/folders/1/sub_folders"
                    }
                },
                "uploads": {
                    "data": [
                        {
                            "id": "1",
                            "type": "uploads"
                        }
                    ],
                    "links": {
                        "related": "http://localhost:3000/v1/folders/1/uploads"
                    }
                }
            },
            "links": {
                "self": "http://localhost:3000/v1/folders/1"
            }
        },
        {
            "id": "4",
            "type": "folders",
            "attributes": {
                "name": "new-folder-02"
            },
            "relationships": {
                "parent": {
                    "data": {
                        "id": "3",
                        "type": "folders"
                    },
                    "links": {
                        "related": "http://localhost:3000/v1/folders/4/parent"
                    }
                },
                "sub-folders": {
                    "data": [],
                    "links": {
                        "related": "http://localhost:3000/v1/folders/4/sub_folders"
                    }
                },
                "uploads": {
                    "data": [],
                    "links": {
                        "related": "http://localhost:3000/v1/folders/4/uploads"
                    }
                }
            },
            "links": {
                "self": "http://localhost:3000/v1/folders/4"
            }
        },
        {
            "id": "5",
            "type": "folders",
            "attributes": {
                "name": "new-folder-04"
            },
            "relationships": {
                "parent": {
                    "data": {
                        "id": "3",
                        "type": "folders"
                    },
                    "links": {
                        "related": "http://localhost:3000/v1/folders/5/parent"
                    }
                },
                "sub-folders": {
                    "data": [
                        {
                            "id": "44",
                            "type": "folders"
                        },
                        {
                            "id": "40",
                            "type": "folders"
                        },
                        {
                            "id": "45",
                            "type": "folders"
                        },
                        {
                            "id": "39",
                            "type": "folders"
                        },
                        {
                            "id": "46",
                            "type": "folders"
                        },
                        {
                            "id": "47",
                            "type": "folders"
                        }
                    ],
                    "links": {
                        "related": "http://localhost:3000/v1/folders/5/sub_folders"
                    }
                },
                "uploads": {
                    "data": [
                        {
                            "id": "3",
                            "type": "uploads"
                        }
                    ],
                    "links": {
                        "related": "http://localhost:3000/v1/folders/5/uploads"
                    }
                }
            },
            "links": {
                "self": "http://localhost:3000/v1/folders/5"
            }
        },
        {
            "id": "7",
            "type": "folders",
            "attributes": {
                "name": "new-folder-04"
            },
            "relationships": {
                "parent": {
                    "data": null,
                    "links": {
                        "related": "http://localhost:3000/v1/folders/7/parent"
                    }
                },
                "sub-folders": {
                    "data": [],
                    "links": {
                        "related": "http://localhost:3000/v1/folders/7/sub_folders"
                    }
                },
                "uploads": {
                    "data": [],
                    "links": {
                        "related": "http://localhost:3000/v1/folders/7/uploads"
                    }
                }
            },
            "links": {
                "self": "http://localhost:3000/v1/folders/7"
            }
        },
        {
            "id": "40",
            "type": "folders",
            "attributes": {
                "name": "new-folder-04"
            },
            "relationships": {
                "parent": {
                    "data": {
                        "id": "5",
                        "type": "folders"
                    },
                    "links": {
                        "related": "http://localhost:3000/v1/folders/40/parent"
                    }
                },
                "sub-folders": {
                    "data": [],
                    "links": {
                        "related": "http://localhost:3000/v1/folders/40/sub_folders"
                    }
                },
                "uploads": {
                    "data": [],
                    "links": {
                        "related": "http://localhost:3000/v1/folders/40/uploads"
                    }
                }
            },
            "links": {
                "self": "http://localhost:3000/v1/folders/40"
            }
        },
        {
            "id": "2",
            "type": "folders",
            "attributes": {
                "name": "new-folder-04"
            },
            "relationships": {
                "parent": {
                    "data": {
                        "id": "1",
                        "type": "folders"
                    },
                    "links": {
                        "related": "http://localhost:3000/v1/folders/2/parent"
                    }
                },
                "sub-folders": {
                    "data": [
                        {
                            "id": "3",
                            "type": "folders"
                        }
                    ],
                    "links": {
                        "related": "http://localhost:3000/v1/folders/2/sub_folders"
                    }
                },
                "uploads": {
                    "data": [],
                    "links": {
                        "related": "http://localhost:3000/v1/folders/2/uploads"
                    }
                }
            },
            "links": {
                "self": "http://localhost:3000/v1/folders/2"
            }
        },
        {
            "id": "3",
            "type": "folders",
            "attributes": {
                "name": "new-folder-04"
            },
            "relationships": {
                "parent": {
                    "data": {
                        "id": "2",
                        "type": "folders"
                    },
                    "links": {
                        "related": "http://localhost:3000/v1/folders/3/parent"
                    }
                },
                "sub-folders": {
                    "data": [
                        {
                            "id": "4",
                            "type": "folders"
                        },
                        {
                            "id": "5",
                            "type": "folders"
                        }
                    ],
                    "links": {
                        "related": "http://localhost:3000/v1/folders/3/sub_folders"
                    }
                },
                "uploads": {
                    "data": [],
                    "links": {
                        "related": "http://localhost:3000/v1/folders/3/uploads"
                    }
                }
            },
            "links": {
                "self": "http://localhost:3000/v1/folders/3"
            }
        },
        {
            "id": "39",
            "type": "folders",
            "attributes": {
                "name": "new-folder-068"
            },
            "relationships": {
                "parent": {
                    "data": {
                        "id": "5",
                        "type": "folders"
                    },
                    "links": {
                        "related": "http://localhost:3000/v1/folders/39/parent"
                    }
                },
                "sub-folders": {
                    "data": [],
                    "links": {
                        "related": "http://localhost:3000/v1/folders/39/sub_folders"
                    }
                },
                "uploads": {
                    "data": [
                        {
                            "id": "4",
                            "type": "uploads"
                        },
                        {
                            "id": "6",
                            "type": "uploads"
                        },
                        {
                            "id": "7",
                            "type": "uploads"
                        },
                        {
                            "id": "8",
                            "type": "uploads"
                        },
                        {
                            "id": "9",
                            "type": "uploads"
                        },
                        {
                            "id": "10",
                            "type": "uploads"
                        },
                        {
                            "id": "11",
                            "type": "uploads"
                        },
                        {
                            "id": "12",
                            "type": "uploads"
                        }
                    ],
                    "links": {
                        "related": "http://localhost:3000/v1/folders/39/uploads"
                    }
                }
            },
            "links": {
                "self": "http://localhost:3000/v1/folders/39"
            }
        },
        {
            "id": "8",
            "type": "folders",
            "attributes": {
                "name": "new-folder-06f8"
            },
            "relationships": {
                "parent": {
                    "data": null,
                    "links": {
                        "related": "http://localhost:3000/v1/folders/8/parent"
                    }
                },
                "sub-folders": {
                    "data": [],
                    "links": {
                        "related": "http://localhost:3000/v1/folders/8/sub_folders"
                    }
                },
                "uploads": {
                    "data": [],
                    "links": {
                        "related": "http://localhost:3000/v1/folders/8/uploads"
                    }
                }
            },
            "links": {
                "self": "http://localhost:3000/v1/folders/8"
            }
        }
    ],
    "links": {
        "self": "http://localhost:3000/v1/folders?page%5Bnumber%5D=1&page%5Bsize%5D=25&q%5Bname_i_cont%5D=new",
        "first": "http://localhost:3000/v1/folders?page%5Bnumber%5D=1&page%5Bsize%5D=25&q%5Bname_i_cont%5D=new",
        "prev": null,
        "next": null,
        "last": "http://localhost:3000/v1/folders?page%5Bnumber%5D=1&page%5Bsize%5D=25&q%5Bname_i_cont%5D=new"
    }
}
```
**Listando Sub Pastas**
 
```sh
[GET] List Sub Folders
/v1/folders/:id/sub_folders
```
**Exemplo de retorno**
```sh
{
    "data": [
        {
            "id": "44",
            "type": "folders",
            "attributes": {
                "name": "foldddddder-3d24dsd2fsddfd42s"
            },
            "relationships": {
                "parent": {
                    "data": {
                        "id": "5",
                        "type": "folders"
                    },
                    "links": {
                        "related": "http://localhost:3000/v1/folders/44/parent"
                    }
                },
                "sub-folders": {
                    "data": [],
                    "links": {
                        "related": "http://localhost:3000/v1/folders/44/sub_folders"
                    }
                },
                "uploads": {
                    "data": [],
                    "links": {
                        "related": "http://localhost:3000/v1/folders/44/uploads"
                    }
                }
            },
            "links": {
                "self": "http://localhost:3000/v1/folders/44"
            }
        },
        {
            "id": "40",
            "type": "folders",
            "attributes": {
                "name": "new-folder-04"
            },
            "relationships": {
                "parent": {
                    "data": {
                        "id": "5",
                        "type": "folders"
                    },
                    "links": {
                        "related": "http://localhost:3000/v1/folders/40/parent"
                    }
                },
                "sub-folders": {
                    "data": [],
                    "links": {
                        "related": "http://localhost:3000/v1/folders/40/sub_folders"
                    }
                },
                "uploads": {
                    "data": [],
                    "links": {
                        "related": "http://localhost:3000/v1/folders/40/uploads"
                    }
                }
            },
            "links": {
                "self": "http://localhost:3000/v1/folders/40"
            }
        },
        {
            "id": "45",
            "type": "folders",
            "attributes": {
                "name": "nova-pasta"
            },
            "relationships": {
                "parent": {
                    "data": {
                        "id": "5",
                        "type": "folders"
                    },
                    "links": {
                        "related": "http://localhost:3000/v1/folders/45/parent"
                    }
                },
                "sub-folders": {
                    "data": [],
                    "links": {
                        "related": "http://localhost:3000/v1/folders/45/sub_folders"
                    }
                },
                "uploads": {
                    "data": [],
                    "links": {
                        "related": "http://localhost:3000/v1/folders/45/uploads"
                    }
                }
            },
            "links": {
                "self": "http://localhost:3000/v1/folders/45"
            }
        },
        {
            "id": "39",
            "type": "folders",
            "attributes": {
                "name": "new-folder-068"
            },
            "relationships": {
                "parent": {
                    "data": {
                        "id": "5",
                        "type": "folders"
                    },
                    "links": {
                        "related": "http://localhost:3000/v1/folders/39/parent"
                    }
                },
                "sub-folders": {
                    "data": [],
                    "links": {
                        "related": "http://localhost:3000/v1/folders/39/sub_folders"
                    }
                },
                "uploads": {
                    "data": [
                        {
                            "id": "4",
                            "type": "uploads"
                        },
                        {
                            "id": "6",
                            "type": "uploads"
                        },
                        {
                            "id": "7",
                            "type": "uploads"
                        },
                        {
                            "id": "8",
                            "type": "uploads"
                        },
                        {
                            "id": "9",
                            "type": "uploads"
                        },
                        {
                            "id": "10",
                            "type": "uploads"
                        },
                        {
                            "id": "11",
                            "type": "uploads"
                        },
                        {
                            "id": "12",
                            "type": "uploads"
                        }
                    ],
                    "links": {
                        "related": "http://localhost:3000/v1/folders/39/uploads"
                    }
                }
            },
            "links": {
                "self": "http://localhost:3000/v1/folders/39"
            }
        },
        {
            "id": "46",
            "type": "folders",
            "attributes": {
                "name": "nova-pasta1"
            },
            "relationships": {
                "parent": {
                    "data": {
                        "id": "5",
                        "type": "folders"
                    },
                    "links": {
                        "related": "http://localhost:3000/v1/folders/46/parent"
                    }
                },
                "sub-folders": {
                    "data": [],
                    "links": {
                        "related": "http://localhost:3000/v1/folders/46/sub_folders"
                    }
                },
                "uploads": {
                    "data": [],
                    "links": {
                        "related": "http://localhost:3000/v1/folders/46/uploads"
                    }
                }
            },
            "links": {
                "self": "http://localhost:3000/v1/folders/46"
            }
        },
        {
            "id": "47",
            "type": "folders",
            "attributes": {
                "name": "nova-pasta4"
            },
            "relationships": {
                "parent": {
                    "data": {
                        "id": "5",
                        "type": "folders"
                    },
                    "links": {
                        "related": "http://localhost:3000/v1/folders/47/parent"
                    }
                },
                "sub-folders": {
                    "data": [],
                    "links": {
                        "related": "http://localhost:3000/v1/folders/47/sub_folders"
                    }
                },
                "uploads": {
                    "data": [],
                    "links": {
                        "related": "http://localhost:3000/v1/folders/47/uploads"
                    }
                }
            },
            "links": {
                "self": "http://localhost:3000/v1/folders/47"
            }
        }
    ]
}
```
**Recuperando a pasta pai**
 
```sh
[GET] Get Parent Folder
/v1/folders/:id/parent
```
**Exemplo de retorno**
```sh
{
    "data": {
        "id": "3",
        "type": "folders",
        "attributes": {
            "name": "new-folder-04"
        },
        "relationships": {
            "parent": {
                "data": {
                    "id": "2",
                    "type": "folders"
                },
                "links": {
                    "related": "http://localhost:3000/v1/folders/3/parent"
                }
            },
            "sub-folders": {
                "data": [
                    {
                        "id": "4",
                        "type": "folders"
                    },
                    {
                        "id": "5",
                        "type": "folders"
                    }
                ],
                "links": {
                    "related": "http://localhost:3000/v1/folders/3/sub_folders"
                }
            },
            "uploads": {
                "data": [],
                "links": {
                    "related": "http://localhost:3000/v1/folders/3/uploads"
                }
            }
        },
        "links": {
            "self": "http://localhost:3000/v1/folders/3"
        }
    }
}
```
### Arquivos
**Criando um arquivo**
 
```sh
[POST] Create
/v1/folders/:id/uploads
{
    "data": {        
        "type": "uploads",
        "attributes": {
            "folder_id": 39,
            "file": "data:image/png;base64,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"
        }
    }
}
```
**Exemplo de retorno**
```sh
{
    "data": {
        "id": "13",
        "type": "uploads",
        "attributes": {
            "file": {
                "name": "file",
                "record": {
                    "id": 13,
                    "folder_id": 39,
                    "created_at": "2022-09-02T06:05:58.163Z",
                    "updated_at": "2022-09-02T06:05:58.205Z"
                }
            },
            "url": "https://ruby-clicksign-bucket-development.s3.amazonaws.com/3zirr15gpd7xtzds9jm3to8ib7s9?response-content-disposition=inline%3B%20filename%3D%22upload-1662098758.jpg%22%3B%20filename%2A%3DUTF-8%27%27upload-1662098758.jpg&response-content-type=image%2Fpng&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIASVKFQP64MWGDFEYW%2F20220902%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20220902T060559Z&X-Amz-Expires=300&X-Amz-SignedHeaders=host&X-Amz-Signature=3a5c6e15858fe381fd636356303d2de2d825de259cb5b95011b63a392853aa79"
        },
        "relationships": {
            "folder": {
                "data": {
                    "id": "39",
                    "type": "folders"
                },
                "links": {
                    "related": "http://localhost:3000/v1/folders/39"
                }
            }
        },
        "links": {
            "self": "http://localhost:3000/v1/folders/39/uploads/13"
        }
    }
}
```
**Atualizando um arquivo**
 
```sh
[PATCH] Update
/v1/folders/:folder_id/uploads/:id
{
    "data": {           
        "id": 5,
        "type": "uploads",
        "attributes": {                
            "file": "data:image/png;base64,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"
        }
    }
}
```
**Recuperando um arquivo**
 
```sh
[GET] Get
/v1/folders/:folder_id/uploads/:id
```
**Exemplo de retorno**
```sh
{
    "data": {
        "id": "13",
        "type": "uploads",
        "attributes": {
            "file": {
                "name": "file",
                "record": {
                    "id": 13,
                    "folder_id": 39,
                    "created_at": "2022-09-02T06:05:58.163Z",
                    "updated_at": "2022-09-02T06:05:58.205Z"
                }
            },
            "url": "https://ruby-clicksign-bucket-development.s3.amazonaws.com/3zirr15gpd7xtzds9jm3to8ib7s9?response-content-disposition=inline%3B%20filename%3D%22upload-1662098758.jpg%22%3B%20filename%2A%3DUTF-8%27%27upload-1662098758.jpg&response-content-type=image%2Fpng&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIASVKFQP64MWGDFEYW%2F20220902%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20220902T060928Z&X-Amz-Expires=300&X-Amz-SignedHeaders=host&X-Amz-Signature=2ac3df986d386d2e7a34fe38880ccbaea502d2db92b2fc834cf752ff0532201f"
        },
        "relationships": {
            "folder": {
                "data": {
                    "id": "39",
                    "type": "folders"
                },
                "links": {
                    "related": "http://localhost:3000/v1/folders/39"
                }
            }
        },
        "links": {
            "self": "http://localhost:3000/v1/folders/39/uploads/13"
        }
    }
}
```
**Deletando um arquivo**
 
```sh
[DELETE] Delete
/v1/folders/:folder_id/uploads/:id
```
**Deletando um arquivo**
 
```sh
[GET] Index
/v1/folders/:folder_id/uploads?q[file_attachment_blob_filename_i_cont]=
```
**Exemplo de retorno**
```sh
{
    "data": [
        {
            "id": "4",
            "type": "uploads",
            "attributes": {
                "file": {
                    "name": "file",
                    "record": {
                        "id": 4,
                        "folder_id": 39,
                        "created_at": "2022-09-01T08:09:14.623Z",
                        "updated_at": "2022-09-01T08:09:14.679Z"
                    }
                },
                "url": "https://ruby-clicksign-bucket-development.s3.amazonaws.com/f10cts5blpardpa9vsi53kbr2gja?response-content-disposition=inline%3B%20filename%3D%22signature-1662019754.jpg%22%3B%20filename%2A%3DUTF-8%27%27signature-1662019754.jpg&response-content-type=image%2Fpng&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIASVKFQP64MWGDFEYW%2F20220902%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20220902T061225Z&X-Amz-Expires=300&X-Amz-SignedHeaders=host&X-Amz-Signature=81815acdaee3b336dfc811c52cfd9794ac9fc6a87aa505c7087a1fe62307f0a1"
            },
            "relationships": {
                "folder": {
                    "data": {
                        "id": "39",
                        "type": "folders"
                    },
                    "links": {
                        "related": "http://localhost:3000/v1/folders/39"
                    }
                }
            },
            "links": {
                "self": "http://localhost:3000/v1/folders/39/uploads/4"
            }
        },
        {
            "id": "6",
            "type": "uploads",
            "attributes": {
                "file": {
                    "name": "file",
                    "record": {
                        "id": 6,
                        "folder_id": 39,
                        "created_at": "2022-09-01T15:28:49.799Z",
                        "updated_at": "2022-09-01T15:42:31.272Z"
                    }
                },
                "url": "https://ruby-clicksign-bucket-development.s3.amazonaws.com/3ad0ezpwweawdhsk0dc0vhp6t78w?response-content-disposition=inline%3B%20filename%3D%22signature-1662046951.jpg%22%3B%20filename%2A%3DUTF-8%27%27signature-1662046951.jpg&response-content-type=image%2Fpng&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIASVKFQP64MWGDFEYW%2F20220902%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20220902T061226Z&X-Amz-Expires=300&X-Amz-SignedHeaders=host&X-Amz-Signature=abdfea027ab634e114c9f7d7cef40b576969384e5f1f50dc0a8ac6ab272cacae"
            },
            "relationships": {
                "folder": {
                    "data": {
                        "id": "39",
                        "type": "folders"
                    },
                    "links": {
                        "related": "http://localhost:3000/v1/folders/39"
                    }
                }
            },
            "links": {
                "self": "http://localhost:3000/v1/folders/39/uploads/6"
            }
        },
        {
            "id": "7",
            "type": "uploads",
            "attributes": {
                "file": {
                    "name": "file",
                    "record": {
                        "id": 7,
                        "folder_id": 39,
                        "created_at": "2022-09-01T15:51:40.733Z",
                        "updated_at": "2022-09-01T15:51:40.759Z"
                    }
                },
                "url": "https://ruby-clicksign-bucket-development.s3.amazonaws.com/of5neg2ofnhk2psxrjbmww299w00?response-content-disposition=inline%3B%20filename%3D%22upload.jpg%22%3B%20filename%2A%3DUTF-8%27%27upload.jpg&response-content-type=image%2Fpng&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIASVKFQP64MWGDFEYW%2F20220902%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20220902T061226Z&X-Amz-Expires=300&X-Amz-SignedHeaders=host&X-Amz-Signature=c47a0e13f0a13f490bb18941d05e49cd44cbaa8458d12ba2139bfc03e6af36ab"
            },
            "relationships": {
                "folder": {
                    "data": {
                        "id": "39",
                        "type": "folders"
                    },
                    "links": {
                        "related": "http://localhost:3000/v1/folders/39"
                    }
                }
            },
            "links": {
                "self": "http://localhost:3000/v1/folders/39/uploads/7"
            }
        },
        {
            "id": "8",
            "type": "uploads",
            "attributes": {
                "file": {
                    "name": "file",
                    "record": {
                        "id": 8,
                        "folder_id": 39,
                        "created_at": "2022-09-01T19:11:18.830Z",
                        "updated_at": "2022-09-01T19:11:18.865Z"
                    }
                },
                "url": "https://ruby-clicksign-bucket-development.s3.amazonaws.com/hswvj0p5dy54bb7r7pme0gjolzog?response-content-disposition=inline%3B%20filename%3D%22upload-1662059478.jpg%22%3B%20filename%2A%3DUTF-8%27%27upload-1662059478.jpg&response-content-type=image%2Fpng&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIASVKFQP64MWGDFEYW%2F20220902%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20220902T061226Z&X-Amz-Expires=300&X-Amz-SignedHeaders=host&X-Amz-Signature=bb0db1e35010338737f3bdb2bf08479cc82960cfc956f30f0ec65e6bceaa7ec4"
            },
            "relationships": {
                "folder": {
                    "data": {
                        "id": "39",
                        "type": "folders"
                    },
                    "links": {
                        "related": "http://localhost:3000/v1/folders/39"
                    }
                }
            },
            "links": {
                "self": "http://localhost:3000/v1/folders/39/uploads/8"
            }
        },
        {
            "id": "9",
            "type": "uploads",
            "attributes": {
                "file": {
                    "name": "file",
                    "record": {
                        "id": 9,
                        "folder_id": 39,
                        "created_at": "2022-09-01T19:15:56.756Z",
                        "updated_at": "2022-09-01T19:15:56.773Z"
                    }
                },
                "url": "https://ruby-clicksign-bucket-development.s3.amazonaws.com/ejgsso5vbiy7dvba6agvh8eqzn6q?response-content-disposition=inline%3B%20filename%3D%22upload-1662059756.jpg%22%3B%20filename%2A%3DUTF-8%27%27upload-1662059756.jpg&response-content-type=image%2Fpng&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIASVKFQP64MWGDFEYW%2F20220902%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20220902T061226Z&X-Amz-Expires=300&X-Amz-SignedHeaders=host&X-Amz-Signature=4572d47a20a4d7abfe5615424d1432cb0e983af20f6767113d79783d0b9b3ef8"
            },
            "relationships": {
                "folder": {
                    "data": {
                        "id": "39",
                        "type": "folders"
                    },
                    "links": {
                        "related": "http://localhost:3000/v1/folders/39"
                    }
                }
            },
            "links": {
                "self": "http://localhost:3000/v1/folders/39/uploads/9"
            }
        },
        {
            "id": "10",
            "type": "uploads",
            "attributes": {
                "file": {
                    "name": "file",
                    "record": {
                        "id": 10,
                        "folder_id": 39,
                        "created_at": "2022-09-01T19:19:53.197Z",
                        "updated_at": "2022-09-01T19:19:53.211Z"
                    }
                },
                "url": "https://ruby-clicksign-bucket-development.s3.amazonaws.com/jrgkpjg0vs6wyicvnb62d6jr69u4?response-content-disposition=inline%3B%20filename%3D%22upload-1662059993.jpg%22%3B%20filename%2A%3DUTF-8%27%27upload-1662059993.jpg&response-content-type=image%2Fpng&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIASVKFQP64MWGDFEYW%2F20220902%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20220902T061226Z&X-Amz-Expires=300&X-Amz-SignedHeaders=host&X-Amz-Signature=b1a86b0843c525437a98b850be9b5c1dcf88f66ca59ae1fe4221d03eb9794cbd"
            },
            "relationships": {
                "folder": {
                    "data": {
                        "id": "39",
                        "type": "folders"
                    },
                    "links": {
                        "related": "http://localhost:3000/v1/folders/39"
                    }
                }
            },
            "links": {
                "self": "http://localhost:3000/v1/folders/39/uploads/10"
            }
        },
        {
            "id": "11",
            "type": "uploads",
            "attributes": {
                "file": {
                    "name": "file",
                    "record": {
                        "id": 11,
                        "folder_id": 39,
                        "created_at": "2022-09-01T19:25:52.236Z",
                        "updated_at": "2022-09-01T19:25:52.247Z"
                    }
                },
                "url": "https://ruby-clicksign-bucket-development.s3.amazonaws.com/jnhrig12hyqivmyi18na80z89sht?response-content-disposition=inline%3B%20filename%3D%22upload-1662060351.jpg%22%3B%20filename%2A%3DUTF-8%27%27upload-1662060351.jpg&response-content-type=image%2Fpng&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIASVKFQP64MWGDFEYW%2F20220902%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20220902T061226Z&X-Amz-Expires=300&X-Amz-SignedHeaders=host&X-Amz-Signature=ce5b56cb33997c1d3166128d89ebe59f3243a622271e5cf6fc5d8d55f9a6e71a"
            },
            "relationships": {
                "folder": {
                    "data": {
                        "id": "39",
                        "type": "folders"
                    },
                    "links": {
                        "related": "http://localhost:3000/v1/folders/39"
                    }
                }
            },
            "links": {
                "self": "http://localhost:3000/v1/folders/39/uploads/11"
            }
        },
        {
            "id": "12",
            "type": "uploads",
            "attributes": {
                "file": {
                    "name": "file",
                    "record": {
                        "id": 12,
                        "folder_id": 39,
                        "created_at": "2022-09-02T04:33:38.185Z",
                        "updated_at": "2022-09-02T04:33:38.209Z"
                    }
                },
                "url": "https://ruby-clicksign-bucket-development.s3.amazonaws.com/0tj71uc6bp5f3dmrie8j6uwr7nyo?response-content-disposition=inline%3B%20filename%3D%22upload-1662093217.jpg%22%3B%20filename%2A%3DUTF-8%27%27upload-1662093217.jpg&response-content-type=image%2Fpng&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIASVKFQP64MWGDFEYW%2F20220902%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20220902T061226Z&X-Amz-Expires=300&X-Amz-SignedHeaders=host&X-Amz-Signature=8b88385cf00a65b1268757594fedaeabfd38a0d7d43d7baacdf890376d092534"
            },
            "relationships": {
                "folder": {
                    "data": {
                        "id": "39",
                        "type": "folders"
                    },
                    "links": {
                        "related": "http://localhost:3000/v1/folders/39"
                    }
                }
            },
            "links": {
                "self": "http://localhost:3000/v1/folders/39/uploads/12"
            }
        },
        {
            "id": "13",
            "type": "uploads",
            "attributes": {
                "file": {
                    "name": "file",
                    "record": {
                        "id": 13,
                        "folder_id": 39,
                        "created_at": "2022-09-02T06:05:58.163Z",
                        "updated_at": "2022-09-02T06:05:58.205Z"
                    }
                },
                "url": "https://ruby-clicksign-bucket-development.s3.amazonaws.com/3zirr15gpd7xtzds9jm3to8ib7s9?response-content-disposition=inline%3B%20filename%3D%22upload-1662098758.jpg%22%3B%20filename%2A%3DUTF-8%27%27upload-1662098758.jpg&response-content-type=image%2Fpng&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIASVKFQP64MWGDFEYW%2F20220902%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20220902T061226Z&X-Amz-Expires=300&X-Amz-SignedHeaders=host&X-Amz-Signature=8d51c505744a1da2893074bfb1e9188504f0ad904cc774533b04154148e2cc6e"
            },
            "relationships": {
                "folder": {
                    "data": {
                        "id": "39",
                        "type": "folders"
                    },
                    "links": {
                        "related": "http://localhost:3000/v1/folders/39"
                    }
                }
            },
            "links": {
                "self": "http://localhost:3000/v1/folders/39/uploads/13"
            }
        }
    ],
    "links": {
        "self": "http://localhost:3000/v1/folders/39/uploads?page%5Bnumber%5D=1&page%5Bsize%5D=25&q%5Bfile_attachment_blob_filename_i_cont%5D=",
        "first": "http://localhost:3000/v1/folders/39/uploads?page%5Bnumber%5D=1&page%5Bsize%5D=25&q%5Bfile_attachment_blob_filename_i_cont%5D=",
        "prev": null,
        "next": null,
        "last": "http://localhost:3000/v1/folders/39/uploads?page%5Bnumber%5D=1&page%5Bsize%5D=25&q%5Bfile_attachment_blob_filename_i_cont%5D="
    }
}
```
