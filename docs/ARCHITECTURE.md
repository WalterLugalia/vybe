# Application Architecture

## 1. Architecture Overview

The application follows a layered architecture using Flutter, Riverpod and a repository-service pattern.

The objective is to separate presentation, state management, data coordination and external communication.

## 2. Layer Flow

All application data operations must follow this direction:

**Screen → Provider → Repository → Service → Backend**

Each layer has a defined responsibility:

- **Screen:** Displays the UI and handles user interactions.
- **Provider:** Manages application state and coordinates actions.
- **Repository:** Coordinates data operations and applies data-related business rules.
- **Service:** Handles communication with external APIs, databases and storage systems.
- **Backend:** Provides external data and services, including Supabase and Mux.

## 3. Screen Conventions

- Screens must not communicate directly with Dio, Supabase, Mux or Hive.
- Screens must not contain backend communication logic.
- Screens obtain application data through Riverpod providers.
- Screens are responsible for displaying loading, success, empty and error states.
- User actions must be delegated to the appropriate provider.

## 4. Riverpod Conventions

- Use `Provider` to expose dependencies such as services and repositories.
- Use `AsyncNotifier` for asynchronous state management and actions.
- Keep unrelated application state in separate providers.
- Reuse existing providers instead of creating duplicate dependencies.
- Follow the provider naming conventions defined in section 3.3 of the project roadmap.

## 5. Repository Conventions

- Repositories coordinate data operations.
- Repositories communicate with services rather than directly accessing external APIs from presentation code.
- Repositories are responsible for converting external data into application models where necessary.
- Repositories should hide implementation details from providers and screens.

## 6. Service Conventions

- Services handle communication with external systems.
- Dio is used for HTTP communication where appropriate.
- Supabase operations are handled through the appropriate service.
- Mux operations are handled through the Mux service.
- Hive operations are handled through the local storage service.

## 7. General Rules

- Follow the established project architecture when adding new features.
- Do not bypass architectural layers without an explicit architectural decision.
- Reuse existing services, repositories and providers where appropriate.
- Keep responsibilities separated and avoid unnecessary duplication.
- Update this document whenever the project's architectural conventions change.