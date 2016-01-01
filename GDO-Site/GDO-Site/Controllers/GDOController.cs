using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace GDO_Site.Controllers
{
    [RoutePrefix("api/GDO")]
    public class GDOController : ApiController
    {
        [HttpGet]
        [Route("ToggleDoor")]
        public JObject SendCommand()
        {
            string command;
            var directory = System.Web.HttpContext.Current.Server.MapPath("/Commands");
            var filepath = Directory.GetFiles(directory, "commands.txt");
            var path = Path.Combine(directory, filepath[0]);
            string text = System.IO.File.ReadAllText(@path).Trim();

            JObject response = new JObject();

            if (text.Trim() == "0")
            {
                command = "1";
            } else
            {
                command = "0";
            }

            File.WriteAllText(@path, String.Empty);

            using (System.IO.StreamWriter file =
            new System.IO.StreamWriter(@path, true))
            {
                file.WriteLine(command);
            }


            response["Message"] = "OK";
            return response;
        }
    }
}
