using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using Desafio.DAO;
using Desafio.Models;
using Desafio.ViewModel;
using System.Data.SqlClient;

namespace Desafio.Controllers
{
    public class ProdutosController : Controller
    {
        private DesafioContext db = new DesafioContext();

        public ActionResult Index(string msg)
        {
            var produto = db.Produto.Include(p => p.categoria);

            ViewBag.msg = msg;
            return View(produto.ToList());
        }

        public ActionResult Create()
        {
            ViewBag.CategoriaId = new SelectList(db.Categoria, "CategoriaId", "nome");
            return View();
        }
        
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(ProdutoViewModel pvm)
        {
            string output = "";
            if (ModelState.IsValid)
            {

                try
                {
                    SqlConnection connection = new SqlConnection(db.Database.Connection.ConnectionString);
                    SqlCommand cmd = new SqlCommand();
                    cmd = new SqlCommand("sp_InserirProduto", connection);
                    cmd.Parameters.AddWithValue("@Nome", pvm.nome);
                    cmd.Parameters.AddWithValue("@Descricao", pvm.descricao);
                    cmd.Parameters.AddWithValue("@CategoriaId", pvm.CategoriaId);
                    cmd.Parameters.AddWithValue("@Preco", pvm.preco);
                    cmd.Parameters.AddWithValue("@Ativo", pvm.ativo);
                    cmd.Parameters.Add("@NomeProduto", SqlDbType.VarChar, 50);
                    cmd.Parameters["@NomeProduto"].Direction = ParameterDirection.Output;
                    cmd.CommandType = CommandType.StoredProcedure;
                    
                    connection.Open();
                    cmd.ExecuteNonQuery();
                    connection.Close();

                    output = cmd.Parameters["@NomeProduto"].Value.ToString();
                }
                catch (Exception ex)
                {
                    //ex.Message;
                }
                
                return RedirectToAction("Index", "Produtos", new { msg = "Produto: " + output + " - Inserido com sucesso." });
            }

            ViewBag.CategoriaId = new SelectList(db.Categoria, "CategoriaId", "nome", pvm.CategoriaId);
            return View(pvm);
        }

        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Produtos produto = db.Produto.Find(id);
            ProdutoViewModel pvm = new ProdutoViewModel();
            pvm.ProdutoId = produto.ProdutosId;
            pvm.nome = produto.nome;
            pvm.descricao = produto.descricao;
            pvm.preco = produto.preco;
            pvm.CategoriaId = produto.categoria.CategoriaId;
            pvm.ativo = produto.ativo;
            if (produto == null)
            {
                return HttpNotFound();
            }
            ViewBag.CategoriaId = new SelectList(db.Categoria, "CategoriaId", "nome", pvm.CategoriaId);
            return View(pvm);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(ProdutoViewModel pvm)
        {
            if (ModelState.IsValid)
            {
                Produtos produto = new Produtos();
                produto.ProdutosId = pvm.ProdutoId;
                produto.nome = pvm.nome;
                produto.descricao = pvm.descricao;
                produto.categoria = new Categoria { CategoriaId = pvm.CategoriaId };
                produto.preco = pvm.preco;
                produto.ativo = pvm.ativo;

                db.Entry(produto).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index", "Produtos", new { msg = "Produto: " + pvm.nome + " - Alterado com sucesso." });
            }
            ViewBag.CategoriaId = new SelectList(db.Categoria, "CategoriaId", "nome", pvm.CategoriaId);
            return View(pvm);
        }

        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Produtos produto = db.Produto.Find(id);
            if (produto == null)
            {
                return HttpNotFound();
            }
            return View(produto);
        }

        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Produtos produto = db.Produto.Find(id);
            db.Produto.Remove(produto);
            db.SaveChanges();
            return RedirectToAction("Index", "Produtos", new { msg = "Produto: " + produto.nome + " - Deletado com sucesso." });
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
