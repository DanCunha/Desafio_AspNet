using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Desafio.Models
{
    public class Produtos
    {
        public int ProdutosId { get; set; }
        public string nome { get; set; }
        public string descricao { get; set; }
        public decimal preco { get; set; }
        public bool ativo { get; set; }
        //public int CategoriaId { get; set; }
        public virtual Categoria categoria { get; set; }
    }
}