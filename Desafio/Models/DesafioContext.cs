using Desafio.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace Desafio.DAO
{
    public class DesafioContext : DbContext
    {
        public DbSet<Produtos> Produto { get; set; }
        public DbSet<Categoria> Categoria { get; set; }

        //protected override void OnModelCreating(DbModelBuilder modelBuilder)
        //{
        //    modelBuilder.Entity<Categoria>()
        //        //.HasOptional(c => c.categoria)
        //        .HasRequired(c => c.produtos)
        //        .WithRequiredPrincipal(x => x.categoria);
        //}
    }
}