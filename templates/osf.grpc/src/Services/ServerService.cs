using Grpc.Core;
using ProjectName;

namespace ProjectName.Services;

public class ServerService : Server.ServerBase
{
    private readonly ILogger<ServerService> _logger;
    public ServerService(ILogger<ServerService> logger)
    {
        _logger = logger;
    }

    public override Task<HelloReply> SayHello(HelloRequest request, ServerCallContext context)
    {
        return Task.FromResult(new HelloReply
        {
            Message = "Hello " + request.Name
        });
    }
}
