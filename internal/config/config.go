package config

import "os"

// Config holds application configuration read from environment variables.
type Config struct {
	Port       string
	DBHost     string
	DBPort     string
	DBUser     string
	DBPassword string
	DBName     string
}

// New reads environment variables and returns a Config with defaults.
func New() *Config {
	return &Config{
		Port:       getEnv("PORT", "8080"),
		DBHost:     getEnv("DB_HOST", "localhost"),
		DBPort:     getEnv("DB_PORT", "5432"),
		DBUser:     getEnv("DB_USER", "postgres"),
		DBPassword: os.Getenv("DB_PASSWORD"),
		DBName:     getEnv("DB_NAME", "treasurer"),
	}
}

func getEnv(key, fallback string) string {
	if v := os.Getenv(key); v != "" {
		return v
	}
	return fallback
}
