# RailsApp - Data Visualization Dashboard

[![GitHub Copilot](https://img.shields.io/badge/GitHub%20Copilot-Enabled-24292F?style=plastic&logo=github&logoColor=white)](https://github.com/features/copilot)
[![Ruby](https://img.shields.io/badge/ruby-3.4.6-red.svg?style=plastic&logo=ruby)](https://www.ruby-lang.org/)
[![Rails](https://img.shields.io/badge/rails-8.0.3-red.svg?style=plastic&logo=rubyonrails)](https://rubyonrails.org/)
[![SQLite](https://img.shields.io/badge/sqlite-3-blue.svg?style=plastic&logo=sqlite)](https://www.sqlite.org/)
[![Test Coverage](https://img.shields.io/badge/coverage-80%25-green.svg?style=plastic&logo=codecov)](https://github.com/jphinspace/RailsApp)
[![Build Status](https://img.shields.io/badge/build-passing-brightgreen.svg?style=plastic&logo=github)](https://github.com/jphinspace/RailsApp)
[![License](https://img.shields.io/badge/license-MIT-blue.svg?style=plastic)](LICENSE)
[![Security](https://img.shields.io/badge/security-up%20to%20date-green.svg?style=plastic&logo=security)](https://github.com/jphinspace/RailsApp)
[![Hotwire](https://img.shields.io/badge/hotwire-turbo%20%26%20stimulus-orange.svg?style=plastic)](https://hotwired.dev/)

A modern Rails 8.0.3 application featuring interactive data visualization with sample datasets. Built with Turbo and Stimulus for dynamic user experiences without complex JavaScript frameworks.

## 🚀 Features

- **Modern Rails 8.0.3** - Latest stable release with all security patches
- **Data Visualization** - Interactive charts and graphs for sample datasets
- **In-Memory Database** - Fast SQLite3 storage for development
- **Turbo & Stimulus** - Hotwire for dynamic interactions without heavy JS
- **No Tailwind CSS** - Clean, custom styling
- **Test Coverage** - Comprehensive test suite with 80%+ line coverage
- **Security First** - Latest versions of all dependencies
- **Best Practices** - Following Rails conventions and modern patterns

## 📊 Sample Data Visualizations

- Sales performance metrics
- User engagement analytics
- Revenue trends over time
- Product category breakdowns

## 🛠 Prerequisites

- Ruby 3.1+ (developed with 3.4.6)
- SQLite3
- Node.js (for asset pipeline)

## 🏃‍♂️ Quick Start

```bash
# Clone the repository
git clone https://github.com/jphinspace/RailsApp.git
cd RailsApp

# Install dependencies
bundle install

# Setup database
rails db:create
rails db:migrate
rails db:seed

# Start the server
rails server
```

Visit `http://localhost:3000` to see the application.

## 🧪 Testing

```bash
# Run the full test suite
rails test

# Run with coverage report
rails test:coverage
```

## 📦 Key Dependencies

- **Rails 8.0.3** - Web framework
- **Turbo Rails** - SPA-like page acceleration
- **Stimulus** - Modest JavaScript framework
- **SQLite3** - Database
- **Importmap** - ES6 modules without bundling

## 🔧 Development

```bash
# Install new gems
bundle install

# Generate migration
rails generate migration CreateModelName

# Console
rails console

# Check routes
rails routes
```

## 🚀 Deployment

This application is ready for deployment with:
- Solid Cache, Queue, and Cable for background processing
- Production-ready configuration
- Containerization can be added later as needed

## � GitHub Copilot Integration

This project is **GitHub Copilot optimized** with comprehensive AI coding agent instructions:

- **📋 `.copilot-instructions.md`** - Complete project context and guidelines
- **🎯 Architecture patterns** - Rails conventions and design decisions
- **🧪 Testing strategies** - 93.75% coverage with best practices
- **🎨 CSS-first approach** - Custom styling without external frameworks
- **⚡ Development workflows** - Common commands and troubleshooting

### For AI Coding Agents:
- Review `.copilot-instructions.md` before making changes
- Maintain Rails conventions and existing patterns
- Keep test coverage above 80% (currently 93.75%)
- Preserve CSS-only visualization approach
- Follow security and best practices guidelines

## �🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Run tests (`rails test`)
4. Commit your changes (`git commit -m 'Add amazing feature'`)
5. Push to the branch (`git push origin feature/amazing-feature`)
6. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🔒 Security

This project uses the latest versions of all dependencies to ensure security patches are applied. Report security issues privately via email.
