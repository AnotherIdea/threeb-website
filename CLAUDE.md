# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a **static website** for ThreeB SAS, a French DevOps and Site Reliability Engineering consulting company. The site targets businesses in the Provence-Alpes-Côte d'Azur region, specifically Aix-en-Provence and Marseille.

## Common Commands

### Development
```bash
# Local development with Docker
docker-compose up --build

# View site at http://localhost:8080
```

### Production Build
```bash
# Build production Docker image
docker build -t threeb-website .

# Run production container
docker run -p 8080:80 threeb-website
```

### Testing
```bash
# Test Docker setup locally
docker-compose up -d
curl -f http://localhost:8080/
curl -f http://localhost:8080/sitemap.xml
curl -f http://localhost:8080/robots.txt

# Check health
docker ps # Should show healthy status
```

## Architecture and Structure

### Technology Stack
- **Frontend**: Pure HTML5/CSS3 (no JavaScript frameworks)
- **Server**: Nginx on Alpine Linux
- **Container**: Docker with multi-architecture support (amd64/arm64)
- **CI/CD**: GitHub Actions with GitHub Container Registry
- **Analytics**: Google Analytics 4 (GA4) with tracking ID `G-TD4YYM76QZ`

### File Organization
```
site/                          # All website content (served by Nginx)
├── index.html                 # Homepage
├── style.css                  # Global styles
├── [21 service pages].html    # SEO-optimized landing pages
├── sitemap.xml               # SEO sitemap
├── robots.txt                # Crawler directives
└── static/                   # Static assets
    └── threeb-logo.png
```

### SEO Strategy
- **Target region**: Provence-Alpes-Côte d'Azur (geo-targeting with coordinates)
- **Business focus**: DevOps/SRE consulting services
- **Content approach**: 21 specialized landing pages covering services, problems, and local keywords
- **Structured data**: Comprehensive JSON-LD markup on all pages
- **Google Analytics**: Integrated on all pages

### Service Pages Categories
1. **Core Services**: infrastructure-as-code.html, ci-cd-modernes.html, observabilite-monitoring.html, site-reliability-engineering.html, architecture-cloud-native.html
2. **Emergency/Urgent**: urgence-sre.html, incident-production-critique.html
3. **Local SEO**: consultant-devops-aix-en-provence.html, formation-devops-aix.html, agence-cloud-provence.html, expert-kubernetes-paca.html, sre-aix-marseille-provence.html
4. **Problem-Solving**: erreur-500-recurrente.html, pipeline-ci-cd-echoue.html, solutions-problemes-devops.html
5. **Specialized**: monitoring-as-a-service.html, audit-disponibilite-sla.html, conseil-devops-sur-mesure.html, formation-kubernetes-avancee.html, guide-observabilite-open-source.html, bonnes-pratiques-sre.html, agence-sre-francaise.html

## Key Configuration Files

### Docker Configuration
- `Dockerfile`: Production-ready Nginx container with optimized configuration
- `docker-compose.yml`: Local development setup (port 8080:80)
- Nginx config includes: gzip compression, static asset caching, security headers, health checks

### GitHub Actions Pipeline
- `.github/workflows/docker-build-deploy.yml`: Automated build/push to GHCR
- Triggers: push to main/develop, tags (v*), pull requests
- Multi-platform builds: linux/amd64, linux/arm64
- Container registry: ghcr.io with private visibility

### SEO Files
- `site/sitemap.xml`: Contains all 23 pages with strategic priority weighting
- `site/robots.txt`: Standard crawl directives and sitemap reference

## Development Patterns

### Page Structure
All pages follow consistent structure:
- Google Analytics tracking code at top of `<head>`
- Comprehensive meta tags (geo-targeting, Open Graph, Twitter Cards)
- Structured data (JSON-LD) for services/organization
- Semantic HTML with proper accessibility attributes
- Consistent navigation and footer

### CSS Architecture
- Single `style.css` file with CSS custom properties
- Responsive design using CSS Grid
- Performance-optimized (external fonts, lazy loading)
- Technology logos loaded from devicons CDN

### Content Guidelines
- **Language**: French (lang="fr")
- **Contact**: contact@threeb.fr (consistent across all pages)
- **Branding**: ThreeB SAS, founded 2024
- **Service area**: 50km radius from Aix-en-Provence coordinates (43.5297, 5.4474)

## Important Business Context

### Company Details
- **Name**: ThreeB SAS
- **Founded**: 2024  
- **Email**: contact@threeb.fr
- **Location**: Aix-en-Provence, France
- **Service Area**: PACA region (Provence-Alpes-Côte d'Azur)

### Technical Expertise Areas
- Infrastructure as Code (Terraform, Ansible)
- CI/CD (GitLab, Azure DevOps, GitHub Actions)
- Observability (Prometheus, Grafana, ELK stack)
- Cloud Architecture (Azure, AWS)
- Container Orchestration (Kubernetes)
- Site Reliability Engineering (SRE practices)

### Target Market
- Geographic: Aix-en-Provence, Marseille, broader PACA region
- Business: Companies needing DevOps transformation
- Services: Technical consulting, training, emergency support

## Deployment Notes

- **Registry**: GitHub Container Registry (ghcr.io)
- **Tagging**: Semantic versioning for releases, branch names for development
- **Health Checks**: Built-in curl monitoring on port 80
- **Caching**: GitHub Actions cache for Docker layers
- **Security**: Comprehensive HTTP security headers configured in Nginx