# VYBE

**Watch something. Discover something. Be part of something.**

VYBE is a video-first social platform built around entertainment, discovery and participation. It brings together short-form video, interest-based communities and shared experiences, giving people more ways to discover content, connect with creators and contribute their own perspectives.

Unlike conventional video platforms built primarily around watching and scrolling, VYBE connects content to people, communities and activities. A video can introduce someone to a new creator, lead them into a community, inspire them to join a challenge or become the starting point for a shared experience.

## The Platform

VYBE brings three interconnected experiences together:

- **Entertainment** — Discover comedy, music, dance, talent, creative videos and content from different creators.
- **Discovery** — Explore places, cultures, travel, food, hobbies and interests through videos and creator experiences.
- **Participation** — Take part in missions, challenges, collaborations and shared activities.

These experiences work together rather than operating as separate parts of the application.

## Core Features

### Discover

The central content experience, bringing together personalized recommendations and videos from followed creators.

Discover includes three content sections:

- **For You** — A personalized selection of videos based on interests and discovery opportunities.
- **Watch** — An entertainment-focused experience featuring comedy, music, dance, talent and creative content.
- **Explore** — A discovery experience centered on places, cultures, hobbies, travel and lifestyle.
- **Participate** — A gateway to missions, challenges and shared experiences.

### Video Trails

Video Trails connect related videos, responses and creator perspectives around a shared subject or experience.

Rather than treating every video as an isolated post, VYBE allows users to follow connections between content and discover different perspectives on the same topic.

### Circles

Interest-based communities where people connect around shared interests.

Members can discover community videos, participate in discussions, explore collections and find missions related to their interests.

### Missions

Structured activities that encourage users to move beyond watching and contribute their own content.

Users can discover missions, review their instructions, join activities, submit videos and explore contributions from other participants.

### Create

The content creation experience allows users to record videos, select existing media and prepare posts for publishing.

Users can add captions, select topics, choose cover images, configure their audience and connect content to relevant experiences.

### Profiles and Collections

Every user has a profile representing their identity and activity on VYBE.

Profiles bring together creator information, published videos, followers, following and collections.

Users can also save videos for later and organize related content into curated collections.

### Social Interactions

VYBE supports interactions that connect creators and their audiences, including:

- Following creators.
- Video comments and discussions.
- Video sharing and saving.
- Notifications and activity updates.
- Followers and following.
- Community participation.

## Application Navigation

The application is organized around five primary destinations:

| Destination | Purpose |
|---|---|
| Discover | Watch videos and discover new content |
| Circles | Connect with interest-based communities |
| Create | Record, upload and publish videos |
| Missions | Discover and participate in activities |
| Profile | Manage personal identity and content |

Watch, Explore and Participate are integrated into Discover rather than being separate primary navigation destinations.

## Technology Stack

| Technology | Responsibility |
|---|---|
| Flutter | Cross-platform application development |
| Dart | Application programming language |
| Riverpod | State management and dependency management |
| GoRouter | Application routing and navigation |
| Supabase | Authentication and backend infrastructure |
| PostgreSQL | Relational database |
| Supabase Storage | Image and file storage |
| Mux | Video upload, processing and streaming |

## Architecture

VYBE follows a feature-first, MVVM-style architecture with repository and service layers.

The codebase separates presentation, state management, data access and external service integrations.

The general application flow is:

```text
Screen
   ↓
Provider / ViewModel
   ↓
Repository
   ↓
Service / Data Source
   ↓
Backend / External Service / Local Storage
```

Each feature owns its relevant screens, widgets, providers, repositories, models and services. Shared functionality is maintained separately to avoid unnecessary duplication and keep feature boundaries clear.

This structure provides a consistent foundation for developing and maintaining the application's different functional areas.

## Media Infrastructure

Video is central to the VYBE experience, so media handling is treated as a dedicated application responsibility.

The planned media architecture uses Mux for video upload, processing and streaming, coordinated through Supabase Edge Functions.

Media operations are kept behind application-level service interfaces so that individual features do not depend directly on the underlying video infrastructure.

## Development Status

VYBE is under active development.

Development follows a phased implementation approach, with each feature implemented, tested and verified before dependent features are introduced.

The project roadmap covers authentication, onboarding, media infrastructure, content discovery, social interactions, communities, missions, content creation and account management.

---

**VYBE — Entertainment brings people in. Discovery keeps them curious. Participation makes them part of the experience.**
