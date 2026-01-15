using Microsoft.EntityFrameworkCore;
using Minimal.TodoApi.Entity;

namespace Minimal.TodoApi.Data;

public class TodoDb(DbContextOptions<TodoDb> options) : DbContext(options)
{
	public DbSet<Todo> Todos => Set<Todo>();
}
