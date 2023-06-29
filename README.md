# CS Teste 1

## Requisitos do Sistema

- RVM
- Ruby 3.2.2

## Notas

### Solução

Para solucionar o problema na camada de modelos, foi implementado três modelos: `FileSystem` (como
entidade raiz que posteriormente poderá ser vinculado à um usuário/organização), `Folder` e
`Document`. Um `FileSystem` pode conter `folders` e `documents`. `Folders` pode conter outras
`Folders` (como uma árvore) e `documents`. `Documents` pertece à um `FileSystem` e pode (ou não)
pertencer a uma `Folder`.

Para persistir os arquivos foi utilizado o `ActiveStorage`, em uma associação ao modelo `Document`.
