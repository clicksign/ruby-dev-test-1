class CreateArquivos < ActiveRecord::Migration[7.0]
  def change
    create_table :arquivos do |t|
      t.boolean :pasta, default: true
      t.string :nome, require: true
      t.string :caminho, require: true
      t.references :diretorio, foreign_key: { to_table: :arquivos }

      t.timestamps
    end
  end
end
