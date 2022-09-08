import Fluent

struct PushMigration: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema(Schema.token)
            .id()
            .field("token", .string, .required)
            .field("debug", .bool, .required)
            .unique(on: "token")
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("tokens").delete()
    }
}
