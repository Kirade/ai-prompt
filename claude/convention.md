# Code Convention Guidelines

This document outlines the coding standards and conventions to follow when working with AI Assistant.

## General Principles

### Code Quality
- Write clean, readable, and maintainable code
- Follow the DRY (Don't Repeat Yourself) principle
- Keep functions and methods focused on a single responsibility
- Prefer clarity over cleverness

### Naming Conventions

#### Variables and Functions
- Use descriptive names that clearly indicate purpose
- Variables: `camelCase` for JavaScript/TypeScript, `snake_case` for Python
- Functions: Verb-based names (e.g., `getUserData`, `calculate_total`)
- Constants: `UPPER_SNAKE_CASE`

#### Classes and Components
- Classes: `PascalCase`
- React Components: `PascalCase`
- Interfaces/Types: `PascalCase` with `I` or `T` prefix when appropriate

### File Organization
- Keep files focused and modular
- Group related functionality together
- Use clear directory structures that reflect the application architecture

## Language-Specific Guidelines

### JavaScript/TypeScript
- Always use `const` or `let`, never `var`
- Prefer arrow functions for callbacks
- Use async/await over Promise chains
- Include proper TypeScript types for all parameters and return values

### Python
- Follow PEP 8 style guide
- Use type hints for function signatures
- Prefer f-strings for string formatting
- Use list comprehensions where appropriate

### React
- Use functional components with hooks
- Keep components small and focused
- Extract custom hooks for reusable logic
- Use proper prop types or TypeScript interfaces

## Error Handling
- Always handle errors appropriately
- Provide meaningful error messages
- Log errors with sufficient context
- Never expose sensitive information in error messages

## Comments and Documentation
- Write self-documenting code
- Add comments only when necessary to explain "why", not "what"
- Keep comments up-to-date with code changes
- Use JSDoc or similar documentation formats

## Testing
- Write tests for critical functionality
- Follow the AAA pattern: Arrange, Act, Assert
- Keep tests focused and independent
- Use descriptive test names

## Version Control
- Write clear, concise commit messages
- Use conventional commit format when applicable
- Keep commits atomic and focused
- Reference issue numbers in commits when relevant