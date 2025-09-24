---
name: GitHub Copilot Assistance
about: Request help from GitHub Copilot coding agents
title: '[COPILOT] '
labels: 'copilot, help wanted'
assignees: ''
---

## 🤖 Copilot Assistance Request

### 📋 Task Description
Clearly describe what you need help with.

### 🎯 Specific Requirements
- [ ] Follow Rails 8.0.3 conventions
- [ ] Maintain 93.75% test coverage
- [ ] Use CSS-only for visualizations
- [ ] No external JavaScript frameworks
- [ ] Keep styling responsive

### 🔍 Context
**Files involved:** (list the files that need changes)
**Current behavior:** (describe what happens now)
**Desired behavior:** (describe what should happen)

### 🧪 Testing Requirements
- [ ] Add unit tests for new functionality
- [ ] Add system tests for user interactions
- [ ] Update fixtures if needed
- [ ] Verify coverage remains above 80%

### 📊 Data Visualization Notes
If this involves charts or data display:
- Maintain CSS-only approach
- Use existing color scheme (purple/blue gradients)
- Ensure responsive design
- Follow existing chart patterns in the codebase

### 🚨 Important Constraints
- **NO Docker** (removed for later containerization)
- **NO Tailwind CSS** (custom CSS only)
- **NO external chart libraries** (CSS-based charts)
- **Latest gem versions only** (security priority)

### 🤖 For AI Coding Agents
**REQUIRED:** Please read `.copilot-instructions.md` before starting work.

Key reminders:
- This is a Rails 8.0.3 + Ruby 3.4.6 project
- Uses Turbo/Stimulus (Hotwire) for interactions
- CSS-first approach for all styling and charts
- Comprehensive test suite with 93.75% coverage
- Sample data includes 975 sales + 3,158 analytics records

### 📋 Acceptance Criteria
- [ ] Solution follows existing project patterns
- [ ] All tests pass (`rails test`)
- [ ] Coverage remains above 80%
- [ ] Code follows Rails conventions
- [ ] Documentation updated if needed
