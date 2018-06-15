namespace Desafio.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class TabelasIniciais : DbMigration
    {
        public override void Up()
        {
            CreateTable(
                "dbo.Categorias",
                c => new
                    {
                        CategoriaId = c.Int(nullable: false, identity: true),
                        nome = c.String(),
                    })
                .PrimaryKey(t => t.CategoriaId);
            
            CreateTable(
                "dbo.Produtos",
                c => new
                    {
                        ProdutosId = c.Int(nullable: false, identity: true),
                        nome = c.String(),
                        descricao = c.String(),
                        preco = c.Decimal(nullable: false, precision: 18, scale: 2),
                        ativo = c.Boolean(nullable: false),
                        categoria_CategoriaId = c.Int(),
                    })
                .PrimaryKey(t => t.ProdutosId)
                .ForeignKey("dbo.Categorias", t => t.categoria_CategoriaId)
                .Index(t => t.categoria_CategoriaId);
            
        }
        
        public override void Down()
        {
            DropForeignKey("dbo.Produtos", "categoria_CategoriaId", "dbo.Categorias");
            DropIndex("dbo.Produtos", new[] { "categoria_CategoriaId" });
            DropTable("dbo.Produtos");
            DropTable("dbo.Categorias");
        }
    }
}
