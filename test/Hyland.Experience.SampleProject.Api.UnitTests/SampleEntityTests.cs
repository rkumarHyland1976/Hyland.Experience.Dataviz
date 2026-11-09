using Hyland.Experience.SampleProject.Domain.Entities;
using Xunit;
using FluentAssertions;

namespace Hyland.Experience.SampleProject.Api.UnitTests;

public class SampleEntityTests
{
    [Fact]
    public void CreateSample_ShouldInitializeProperties()
    {
        // Arrange
        string name = "Test Sample";
        string description = "Test Description";

        // Act
        var sample = new Sample(name, description);

        // Assert
        sample.Name.Should().Be(name);
        sample.Description.Should().Be(description);
        sample.Id.Should().NotBeEmpty();
        sample.CreatedAt.Should().BeCloseTo(DateTime.UtcNow, TimeSpan.FromSeconds(1));
        sample.IsActive.Should().BeTrue();
    }

    [Fact]
    public void UpdateSample_ShouldUpdateProperties()
    {
        // Arrange
        var sample = new Sample("Original", "Original Description");
        var newName = "Updated";
        var newDescription = "Updated Description";

        // Act
        sample.Update(newName, newDescription);

        // Assert
        sample.Name.Should().Be(newName);
        sample.Description.Should().Be(newDescription);
        sample.UpdatedAt.Should().NotBeNull();
        sample.IsActive.Should().BeTrue();
    }

    [Fact]
    public void DeactivateSample_ShouldSetIsActiveFalse()
    {
        // Arrange
        var sample = new Sample("Test", "Test");

        // Act
        sample.Deactivate();

        // Assert
        sample.IsActive.Should().BeFalse();
        sample.UpdatedAt.Should().NotBeNull();
    }
}
