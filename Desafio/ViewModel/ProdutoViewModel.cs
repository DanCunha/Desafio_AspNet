using Desafio.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Desafio.ViewModel
{
    public class ProdutoViewModel
    {
        public int ProdutoId { get; set; }
        [Required(ErrorMessage = "Campo obrigatório")]
        [Display(Name ="Nome")]
        [MaxLength(50, ErrorMessage ="Nome do produto não pode ser maior que 50 caracteres.")]
        public string nome { get; set; }
        [Required(ErrorMessage = "Campo obrigatório")]
        [Display(Name = "Descrição")]
        [MaxLength(200, ErrorMessage = "Descrição não pode conter mais de 200 caracteres.")]
        public string descricao { get; set; }
        [Required]
        [DataType("decimal(18 ,2")]
        [Display(Name ="Preço")]
        public decimal preco { get; set; }
        [Display(Name ="Ativo")]
        public bool ativo { get; set; }
        public int CategoriaId { get; set; }
        public virtual Categoria categoria { get; set; }
    }

}