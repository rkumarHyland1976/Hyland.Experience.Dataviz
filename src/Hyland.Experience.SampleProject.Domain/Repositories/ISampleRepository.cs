using Hyland.Experience.SampleProject.Domain.Entities;

namespace Hyland.Experience.SampleProject.Domain.Repositories;

public interface ISampleRepository
{
    Task<Sample?> GetByIdAsync(Guid id, CancellationToken cancellationToken = default);
    Task<IEnumerable<Sample>> GetAllAsync(CancellationToken cancellationToken = default);
    Task<Sample> AddAsync(Sample sample, CancellationToken cancellationToken = default);
    Task<Sample> UpdateAsync(Sample sample, CancellationToken cancellationToken = default);
    Task DeleteAsync(Guid id, CancellationToken cancellationToken = default);
}
