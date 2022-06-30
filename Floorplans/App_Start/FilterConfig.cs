using System;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace Floorplans
{
    public class FilterConfig
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new HandleErrorAttribute());
        }
    }

    [AttributeUsage(AttributeTargets.Class | AttributeTargets.Method)]
    public class AuthorizeAction1FilterAttribute : ActionFilterAttribute
    {
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            HttpSessionStateBase session = filterContext.HttpContext.Session;
            Controller controller = filterContext.Controller as Controller;

            if (controller != null)
            {
                if (session["Access"] == null)
                {
                    filterContext.Result = new RedirectToRouteResult(new
                                         RouteValueDictionary(new { controller = "Account", action = "Login" }));
                }
            }

            base.OnActionExecuting(filterContext);
        }
    }
}
