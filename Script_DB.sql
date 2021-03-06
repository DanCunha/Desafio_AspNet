USE [master]
GO
/****** Object:  Database [Desafio]    Script Date: 14/06/2018 22:48:37 ******/
CREATE DATABASE [Desafio]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Desafio', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Desafio.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Desafio_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\Desafio_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Desafio] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Desafio].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Desafio] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Desafio] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Desafio] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Desafio] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Desafio] SET ARITHABORT OFF 
GO
ALTER DATABASE [Desafio] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Desafio] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Desafio] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Desafio] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Desafio] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Desafio] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Desafio] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Desafio] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Desafio] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Desafio] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Desafio] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Desafio] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Desafio] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Desafio] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Desafio] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Desafio] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Desafio] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Desafio] SET RECOVERY FULL 
GO
ALTER DATABASE [Desafio] SET  MULTI_USER 
GO
ALTER DATABASE [Desafio] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Desafio] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Desafio] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Desafio] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [Desafio] SET DELAYED_DURABILITY = DISABLED 
GO
USE [Desafio]
GO
/****** Object:  Table [dbo].[Categorias]    Script Date: 14/06/2018 22:48:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categorias](
	[CategoriaId] [int] IDENTITY(1,1) NOT NULL,
	[nome] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.Categorias] PRIMARY KEY CLUSTERED 
(
	[CategoriaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Produtos]    Script Date: 14/06/2018 22:48:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Produtos](
	[ProdutosId] [int] IDENTITY(1,1) NOT NULL,
	[nome] [nvarchar](max) NULL,
	[descricao] [nvarchar](max) NULL,
	[preco] [decimal](18, 2) NOT NULL,
	[ativo] [bit] NOT NULL,
	[categoria_CategoriaId] [int] NULL,
 CONSTRAINT [PK_dbo.Produtos] PRIMARY KEY CLUSTERED 
(
	[ProdutosId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Categorias] ON 

INSERT [dbo].[Categorias] ([CategoriaId], [nome]) VALUES (1, N'Eletronicos')
INSERT [dbo].[Categorias] ([CategoriaId], [nome]) VALUES (2, N'Games')
INSERT [dbo].[Categorias] ([CategoriaId], [nome]) VALUES (3, N'Eletrodomesticos')
INSERT [dbo].[Categorias] ([CategoriaId], [nome]) VALUES (4, N'Acessórios')
SET IDENTITY_INSERT [dbo].[Categorias] OFF
/****** Object:  Index [IX_categoria_CategoriaId]    Script Date: 14/06/2018 22:48:37 ******/
CREATE NONCLUSTERED INDEX [IX_categoria_CategoriaId] ON [dbo].[Produtos]
(
	[categoria_CategoriaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Produtos]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Produtos_dbo.Categorias_categoria_CategoriaId] FOREIGN KEY([categoria_CategoriaId])
REFERENCES [dbo].[Categorias] ([CategoriaId])
GO
ALTER TABLE [dbo].[Produtos] CHECK CONSTRAINT [FK_dbo.Produtos_dbo.Categorias_categoria_CategoriaId]
GO
/****** Object:  StoredProcedure [dbo].[sp_InserirProduto]    Script Date: 14/06/2018 22:48:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_InserirProduto]
      @Nome varchar(50),
	  @Descricao varchar(200),
	  @CategoriaId varchar(50),
	  @Preco decimal(18,2),
	  @Ativo bit,
      @NomeProduto VARCHAR(50) OUTPUT
AS
BEGIN
      SET NOCOUNT ON;

	  INSERT INTO Produtos(nome, descricao, categoria_CategoriaId, preco, ativo)
	  --output inserted.ProdutoId
	  VALUES(@Nome, @Descricao, @CategoriaId, @Preco, @Ativo) 
	  SELECT SCOPE_IDENTITY();
     
      SELECT @NomeProduto = nome
      FROM Produtos
      WHERE ProdutosId = (SELECT SCOPE_IDENTITY())
END


--select * from produtos
GO
USE [master]
GO
ALTER DATABASE [Desafio] SET  READ_WRITE 
GO
