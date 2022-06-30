using Floorplans.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Floorplans.Controllers
{
    [AuthorizeAction1FilterAttribute]
    [Authorize]
    public class UserController : Controller
    {
        
        FloorPlansEntities DB = new FloorPlansEntities();
        // GET: User
        public ActionResult Users(string Success, string Update, string Delete)
        {
            List<tblUser> UserList = DB.tblUsers.Where(x => x.isActive == true).ToList();
            ViewBag.Success = Success;
            ViewBag.Update = Update;
            ViewBag.Delete = Delete;
            return View(UserList);
        }

        public ActionResult CreateUser(int? id)
        {
            tblUser User = null;
            ViewBag.Roles = DB.tblRoles.Where(x => x.isActive == true).ToList();
            if (id != null && id != 0)
            {

                User = DB.tblUsers.Where(x => x.UserId == id).FirstOrDefault();
                return View(User);
            }
            else
            {
                return View(User);
            }
        }

        [HttpPost]
        public ActionResult CreateUser(tblUser User)
        {

            tblUser Data = new tblUser();
            try
            {
                HttpCookie cookieObj = Request.Cookies["User"];
                int UserId = Int32.Parse(cookieObj["UserId"]);
                if (User.UserId == 0)
                {
                    if (DB.tblUsers.Select(r => r).Where(x => x.username == User.username || x.Email == User.Email).FirstOrDefault() == null)
                    {
                        Data = User;
                        byte[] EncDataBtye = new byte[User.Password.Length];
                        EncDataBtye = System.Text.Encoding.UTF8.GetBytes(User.Password);
                        Data.Password = Convert.ToBase64String(EncDataBtye);
                        Data.CreatedDate = Convert.ToDateTime(DateTime.Now.ToString("yyyy-MM-dd"));
                        Data.CreatedBy = UserId;
                        Data.EditDate = Convert.ToDateTime(DateTime.Now.ToString("yyyy-MM-dd"));
                        Data.EditBy = UserId;
                        Data.isActive = true;
                        DB.tblUsers.Add(Data);
                        DB.SaveChanges();
                        return RedirectToAction("Users", new { Success = "User has been add successfully." });
                    }
                    else
                    {
                        ViewBag.Error = "User Already Exsist!!!";
                    }
                }
                else
                {
                    var check = DB.tblUsers.Select(r => r).Where(x => x.username == User.username && x.Email == User.Email).FirstOrDefault();
                    if (check == null || check.UserId == User.UserId)
                    {
                        Data = DB.tblUsers.Select(r => r).Where(x => x.UserId == User.UserId).FirstOrDefault();
                        Data.username = User.username;
                        Data.UserId = User.UserId;
                        Data.FirstName = User.FirstName;
                        Data.LastName = User.LastName;
                        Data.Email = User.Email;
                        Data.RoleId = User.RoleId;
                        if (User.Password != null)
                        {
                            byte[] EncDataBtye = new byte[User.Password.Length];
                            EncDataBtye = System.Text.Encoding.UTF8.GetBytes(User.Password);
                            Data.Password = Convert.ToBase64String(EncDataBtye);
                        }
                        Data.EditDate = Convert.ToDateTime(DateTime.Now.ToString("yyyy-MM-dd"));
                        Data.EditBy = UserId;
                        DB.Entry(Data);
                        DB.SaveChanges();
                        return RedirectToAction("Users", new { Update = "User has been Update successfully." });
                    }
                    else
                    {
                        ViewBag.Error = "User Already Exsist!!!";
                    }

                }


            }
            catch (Exception ex)
            {

                ViewBag.Error = ex.Message;
                Console.WriteLine("Error" + ex.Message);
            }

            return RedirectToAction("Users");
        }

        [HttpPost]
        public ActionResult DeleteUser(int UserId)
        {
            tblUser Data = new tblUser();
            try
            {
                Data = DB.tblUsers.Select(r => r).Where(x => x.UserId == UserId).FirstOrDefault();
                DB.Entry(Data).State = EntityState.Deleted;
                DB.SaveChanges();
                return Json(1);
            }
            catch (Exception ex)
            {

                ViewBag.Error = ex.Message;
                Console.WriteLine("Error" + ex.Message);
            }

            return Json(0);
        }

        public ActionResult RolesPermission(int? id, string Update)
        {
            List<tblRole> Roles = DB.tblRoles.Where(x => x.isActive == true).ToList();
            ViewBag.MenuList = DB.tblMenus.ToList();

            try
            {
                var check = DB.tblAccessLevels.Where(x => x.RoleId == id).FirstOrDefault();
                if (id != null && id != 0 && check != null)
                {
                    ViewBag.SelectedRole = DB.tblRoles.Where(x => x.RoleId == id).FirstOrDefault();

                    ViewBag.SelectedMenuAccess = (from h in DB.tblMenus
                                                  join t in DB.tblAccessLevels.Where(x => x.RoleId == id) on h.MenuId equals t.MenuId into gj
                                                  from acc in gj.DefaultIfEmpty()
                                                      //where acc.roleid == id
                                                  select new MenuAccess
                                                  {
                                                      menu = h,
                                                      //accesslevelid = acc.accesslevelid,
                                                      accessedit = acc.EditAccess,
                                                      accessdelete = acc.DeleteAccess,
                                                      accesscreate = acc.CreateAccess,
                                                      isactive = acc.isActive,
                                                      roleid = id,
                                                      menuid = h.MenuId,

                                                  }).ToList();
                }
                else
                {
                    if (id != null && id != 0)
                    {
                        ViewBag.SelectedRole = DB.tblRoles.Where(x => x.RoleId == id).FirstOrDefault();
                    }
                    else
                    {
                        ViewBag.SelectedRole = null;
                    }
                    ViewBag.SelectedMenuAccess = null;
                }
            }
            catch (Exception ex)
            {

                ViewBag.Error = ex.Message;
                Console.WriteLine("Error" + ex.Message);
            }


            ViewBag.Update = Update;
            return View(Roles);
        }

        [HttpPost]
        public ActionResult CreateRole(string Role, bool? isActive, int RoleId = 0)
        {
            tblRole Data = new tblRole();
            try
            {
                HttpCookie cookieObj = Request.Cookies["User"];
                int UserId = Int32.Parse(cookieObj["UserId"]);
                if (RoleId != 0)
                {

                    tblRole check = DB.tblRoles.Select(r => r).Where(x => x.Role == Role).FirstOrDefault();
                    if (check == null || check.RoleId == RoleId)
                    {
                        Data = DB.tblRoles.Select(r => r).Where(x => x.RoleId == RoleId).FirstOrDefault();

                        Data.Role = Role;
                        Data.isActive = isActive;
                        Data.EditDate = Convert.ToDateTime(DateTime.Now.ToString("yyyy-MM-dd"));
                        Data.EditBy = UserId;
                        DB.Entry(Data);
                        DB.SaveChanges();
                    }
                    else
                    {
                        return Json(1);
                    }

                }
                else
                {
                    if (DB.tblRoles.Select(r => r).Where(x => x.Role == Role).FirstOrDefault() == null)
                    {
                        Data.Role = Role;
                        Data.isActive = isActive;
                        Data.CreatedDate = Convert.ToDateTime(DateTime.Now.ToString("yyyy-MM-dd"));
                        Data.CreatedBy = UserId;
                        Data.EditDate = Convert.ToDateTime(DateTime.Now.ToString("yyyy-MM-dd"));
                        Data.EditBy = UserId;
                        DB.tblRoles.Add(Data);
                        DB.SaveChanges();

                    }
                    else
                    {
                        return Json(1);
                    }
                }

            }
            catch (Exception ex)
            {

                ViewBag.Error = ex.Message;
                Console.WriteLine("Error" + ex.Message);
            }

            return Json(0);
        }

        [HttpPost]
        public ActionResult CreateAccessLevel(List<tblAccessLevel> Items)
        {
            try
            {
                foreach (tblAccessLevel AccessLevel in Items)
                {
                    var Del = DB.tblAccessLevels.Select(r => r).Where(x => x.RoleId == AccessLevel.RoleId && x.MenuId == AccessLevel.MenuId).FirstOrDefault();
                    if (Del != null)
                    {
                        DB.tblAccessLevels.Remove(Del);
                    }
                }

                foreach (tblAccessLevel AccessLevel in Items)
                {
                    AccessLevel.CreatedDate = DateTime.Now;
                    AccessLevel.CreatedBy = 1;
                    AccessLevel.EditDate = DateTime.Now;
                    AccessLevel.EditBy = 1;
                    //AccessLevel.tblMenu = DB.tblMenus.Select(r => r).Where(x => x.MenuID == AccessLevel.MenuID).FirstOrDefault();
                    //AccessLevel.tblRole = DB.tblRoles.Select(r => r).Where(x => x.RoleID == AccessLevel.RoleID).FirstOrDefault();
                    DB.tblAccessLevels.Add(AccessLevel);
                    DB.SaveChanges();
                }
                DB.SaveChanges();

            }
            catch (Exception ex)
            {

                ViewBag.Error = ex.Message;
                Console.WriteLine("Error" + ex.Message);
            }

            return Json(0);
        }
    }
}