using System.Diagnostics.CodeAnalysis;

namespace Hyland.Experience.SampleProject.Domain.Events;

[ExcludeFromCodeCoverage]
public abstract class DomainEvent
{
    public Guid AggregateId { get; protected set; }
    public DateTime OccurredAt { get; protected set; } = DateTime.UtcNow;
    public int Version { get; protected set; }
}
