using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;

namespace Desafio.Models
{
    public class Categoria
    {
        public int CategoriaId { get; set; }
        public string nome { get; set; }
        //public virtual Produtos produtos{ get; set; }
    }
}