namespace Minimal.TodoApi.Entity;
public class Todo
{
	public int Id { get; set; }
	public string? Name { get; set; }
	public bool IsComplete { get; set; }
	public string? Secret { get; set; }
	public DateTime TimeStamp => DateTime.Now;
}
