using Hyland.Experience.SampleProject.Domain.Entities;
using Hyland.Experience.SampleProject.Domain.Repositories;
using Microsoft.EntityFrameworkCore;

namespace Hyland.Experience.SampleProject.Infrastructure.Persistence;

public class SampleContext : DbContext
{
    public SampleContext(DbContextOptions<SampleContext> options) : base(options)
    {
    }

    public DbSet<Sample> Samples { get; set; } = null!;

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        modelBuilder.Entity<Sample>(entity =>
        {
            entity.HasKey(e => e.Id);
            entity.Property(e => e.Name).IsRequired().HasMaxLength(255);
            entity.Property(e => e.Description).HasMaxLength(1000);
            entity.Property(e => e.CreatedAt).IsRequired();
            entity.Property(e => e.IsActive).IsRequired().HasDefaultValue(true);
            entity.HasIndex(e => e.IsActive);
            entity.HasIndex(e => e.CreatedAt);
        });
    }
}

public class SampleRepository : ISampleRepository
{
    private readonly SampleContext _context;

    public SampleRepository(SampleContext context)
    {
        _context = context;
    }

    public async Task<Sample?> GetByIdAsync(Guid id, CancellationToken cancellationToken = default)
    {
        return await _context.Samples.FirstOrDefaultAsync(s => s.Id == id, cancellationToken);
    }

    public async Task<IEnumerable<Sample>> GetAllAsync(CancellationToken cancellationToken = default)
    {
        return await _context.Samples.Where(s => s.IsActive).ToListAsync(cancellationToken);
    }

    public async Task<Sample> AddAsync(Sample sample, CancellationToken cancellationToken = default)
    {
        _context.Samples.Add(sample);
        await _context.SaveChangesAsync(cancellationToken);
        return sample;
    }

    public async Task<Sample> UpdateAsync(Sample sample, CancellationToken cancellationToken = default)
    {
        _context.Samples.Update(sample);
        await _context.SaveChangesAsync(cancellationToken);
        return sample;
    }

    public async Task DeleteAsync(Guid id, CancellationToken cancellationToken = default)
    {
        var sample = await GetByIdAsync(id, cancellationToken);
        if (sample != null)
        {
            _context.Samples.Remove(sample);
            await _context.SaveChangesAsync(cancellationToken);
        }
    }
}
