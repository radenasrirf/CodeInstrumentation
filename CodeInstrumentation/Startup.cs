using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(CodeInstrumentation.Startup))]
namespace CodeInstrumentation
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
