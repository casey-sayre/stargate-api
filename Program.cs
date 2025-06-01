using Microsoft.EntityFrameworkCore;
using StargateAPI.Business.Commands;
using StargateAPI.Business.Data;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowSpecificOrigins",
        policy =>
        {
            // deny all cross origin resource sharing if no AllowedOrigins specified
            // allow any method or header if not specified
            var allowedOrigins = builder.Configuration.GetSection("AllowedHosts").Value?.Split(',') ?? ["none"];
            var allowedMethods = builder.Configuration.GetSection("AllowedMethods").Value?.Split(',') ?? [];
            var allowedHeaders = builder.Configuration.GetSection("AllowedHeaders").Value?.Split(',') ?? [];

            policy.WithOrigins(allowedOrigins);

            if (allowedMethods.Length > 0)
            {
                policy.WithMethods(allowedMethods);
            }
            else
            {
                policy.AllowAnyMethod();
            }
            if (allowedHeaders.Length > 0)
            {
                policy.WithHeaders(allowedHeaders);
            }
            else
            {
                policy.AllowAnyHeader();
            }
        });
});

builder.Services.AddDbContext<StargateContext>(options => 
    options.UseSqlite(builder.Configuration.GetConnectionString("StarbaseApiDatabase")));

builder.Services.AddMediatR(cfg =>
{
    cfg.AddRequestPreProcessor<CreateAstronautDutyPreProcessor>();
    cfg.RegisterServicesFromAssemblies(typeof(Program).Assembly);
});

var app = builder.Build();

// Configure the HTTP request pipeline.

app.UseCors("AllowSpecificOrigins");

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
