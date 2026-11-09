using Hyland.Experience.SampleProject.Domain.Entities;
using MediatR;
using Microsoft.AspNetCore.Mvc;

namespace Hyland.Experience.SampleProject.Api.Controllers;

[ApiController]
[Route("api/[controller]")]
[Produces("application/json")]
public class SampleController : ControllerBase
{
    private readonly IMediator _mediator;
    private readonly ILogger<SampleController> _logger;

    public SampleController(IMediator mediator, ILogger<SampleController> logger)
    {
        _mediator = mediator;
        _logger = logger;
    }

    /// <summary>
    /// Get all samples
    /// </summary>
    [HttpGet]
    [ProducesResponseType(typeof(IEnumerable<Sample>), StatusCodes.Status200OK)]
    public async Task<IActionResult> GetAll()
    {
        _logger.LogInformation("Fetching all samples");
        return Ok(new List<Sample>());
    }

    /// <summary>
    /// Get sample by ID
    /// </summary>
    [HttpGet("{id}")]
    [ProducesResponseType(typeof(Sample), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    public async Task<IActionResult> GetById(Guid id)
    {
        _logger.LogInformation("Fetching sample with ID: {Id}", id);
        return NotFound();
    }

    /// <summary>
    /// Create a new sample
    /// </summary>
    [HttpPost]
    [ProducesResponseType(typeof(Sample), StatusCodes.Status201Created)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public async Task<IActionResult> Create([FromBody] CreateSampleRequest request)
    {
        _logger.LogInformation("Creating new sample with name: {Name}", request.Name);
        var sample = new Sample(request.Name, request.Description);
        return CreatedAtAction(nameof(GetById), new { id = sample.Id }, sample);
    }

    /// <summary>
    /// Update an existing sample
    /// </summary>
    [HttpPut("{id}")]
    [ProducesResponseType(StatusCodes.Status204NoContent)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    public async Task<IActionResult> Update(Guid id, [FromBody] UpdateSampleRequest request)
    {
        _logger.LogInformation("Updating sample with ID: {Id}", id);
        return NoContent();
    }

    /// <summary>
    /// Delete a sample
    /// </summary>
    [HttpDelete("{id}")]
    [ProducesResponseType(StatusCodes.Status204NoContent)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    public async Task<IActionResult> Delete(Guid id)
    {
        _logger.LogInformation("Deleting sample with ID: {Id}", id);
        return NoContent();
    }
}

/// <summary>
/// Request model for creating a sample
/// </summary>
public class CreateSampleRequest
{
    public string Name { get; set; } = string.Empty;
    public string Description { get; set; } = string.Empty;
}

/// <summary>
/// Request model for updating a sample
/// </summary>
public class UpdateSampleRequest
{
    public string Name { get; set; } = string.Empty;
    public string Description { get; set; } = string.Empty;
}
