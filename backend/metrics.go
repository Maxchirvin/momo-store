package main

import (
    "github.com/prometheus/client_golang/prometheus"
    "github.com/prometheus/client_golang/prometheus/promhttp"
    "net/http"
)

var (
    httpRequests = prometheus.NewCounterVec(
        prometheus.CounterOpts{
            Name: "http_requests_total",
            Help: "Total HTTP requests",
        },
        []string{"method", "endpoint", "status"},
    )
    responseTime = prometheus.NewHistogramVec(
        prometheus.HistogramOpts{
            Name: "http_response_time_seconds",
            Help: "HTTP response time",
        },
        []string{"endpoint"},
    )
)

func init() {
    prometheus.MustRegister(httpRequests)
    prometheus.MustRegister(responseTime)
}

func metricsHandler() http.Handler {
    return promhttp.Handler()
}
