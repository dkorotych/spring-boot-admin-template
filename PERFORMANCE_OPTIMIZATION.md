# Performance Optimization Guide

This document outlines the performance optimizations implemented in the Spring Boot Admin application.

## 🚀 Optimizations Implemented

### 1. Application Configuration (`application.yaml`)

#### Spring Boot Admin Optimizations
- **Increased monitoring intervals**: Extended from 5m to 10m to reduce overhead
- **Added info and metrics lifetime**: Configured for better resource management
- **Enabled Thymeleaf caching**: Reduces template compilation overhead

#### Server Optimizations
- **HTTP/2 enabled**: Better multiplexing and header compression
- **Gzip compression**: Reduces response sizes for text-based content
- **Tomcat thread pool tuning**: Optimized for concurrent requests
- **Connection timeout optimization**: Better resource utilization

#### Resource Caching
- **Static resource caching**: 1-hour cache for assets, CSS, JS, images
- **Content-based versioning**: Automatic cache busting for updated resources
- **Fixed versioning**: For static assets that rarely change

#### Monitoring & Metrics
- **Prometheus metrics**: Enabled for performance monitoring
- **Percentile histograms**: Detailed latency metrics
- **SLO definitions**: Service level objectives for response times

### 2. Build Configuration (`build.gradle`)

#### Compilation Optimizations
- **Incremental compilation**: Faster rebuilds
- **Parallel compilation**: Utilizes multiple CPU cores
- **Memory allocation**: 2GB heap for compilation tasks

#### Runtime JVM Optimizations
- **G1 Garbage Collector**: Better for low-latency applications
- **String deduplication**: Reduces memory usage
- **Tiered compilation**: Faster startup with JIT optimization
- **Disabled JMX**: Reduces overhead in production

#### Boot JAR Optimizations
- **Layered JAR**: Better Docker layer caching
- **Optimized launch**: Faster application startup

### 3. Security Configuration

#### Performance-Focused Security
- **Optimized path matching**: Reduced security filter overhead
- **Streamlined authentication handlers**: Minimal processing
- **Disabled unnecessary security features**: Reduced overhead

### 4. JVM Optimization Scripts

#### `start-optimized.sh`
- **G1GC configuration**: Optimized for low pause times
- **CPU intrinsics**: Hardware-accelerated operations
- **Memory settings**: Configurable based on available resources
- **Spring Boot optimizations**: Disabled unnecessary features

#### `jvm-optimization.conf`
- **Comprehensive JVM flags**: All performance-related settings
- **Memory configuration examples**: For different memory sizes
- **GC tuning**: Optimized for Spring Boot applications

### 5. Caching & Monitoring

#### Cache Configuration
- **Caffeine cache**: High-performance in-memory caching
- **Configurable TTL**: 10-minute write, 5-minute access expiration
- **Statistics enabled**: Monitor cache performance

#### Performance Monitoring
- **Micrometer integration**: Application metrics
- **Prometheus export**: Time-series metrics
- **Custom tags**: Application identification

## 📊 Expected Performance Improvements

### Startup Time
- **30-50% faster startup** with JVM optimizations
- **Reduced memory footprint** with lazy initialization
- **Faster compilation** with parallel builds

### Runtime Performance
- **Lower latency** with G1GC and optimized JVM flags
- **Reduced CPU usage** with disabled unnecessary features
- **Better throughput** with optimized thread pools

### Resource Usage
- **Lower memory consumption** with string deduplication
- **Reduced network traffic** with compression
- **Better cache utilization** with optimized caching

## 🛠️ Usage Instructions

### 1. Development
```bash
# Use optimized build
./gradlew bootRun

# Or with custom JVM options
JAVA_OPTS="-Xmx1g -XX:+UseG1GC" ./gradlew bootRun
```

### 2. Production
```bash
# Build optimized JAR
./gradlew bootJar

# Run with optimized settings
./start-optimized.sh
```

### 3. Docker Deployment
```dockerfile
# Use the optimized startup script
COPY start-optimized.sh /app/
RUN chmod +x /app/start-optimized.sh
CMD ["/app/start-optimized.sh"]
```

## 📈 Monitoring

### Metrics Endpoints
- `/actuator/metrics` - Application metrics
- `/actuator/prometheus` - Prometheus format
- `/actuator/health` - Health status

### Key Metrics to Monitor
- `http.server.requests` - Request latency and throughput
- `jvm.memory.used` - Memory usage
- `jvm.gc.pause` - Garbage collection pauses
- `cache.gets` - Cache hit/miss ratios

## 🔧 Customization

### Memory Settings
Adjust memory settings in `start-optimized.sh` based on available resources:
- **1GB total**: `-Xms512m -Xmx1g`
- **2GB total**: `-Xms1g -Xmx2g`
- **4GB total**: `-Xms2g -Xmx4g`

### Cache Configuration
Modify `CacheConfiguration.java` for different caching strategies:
- **Size limits**: Adjust `maximumSize()`
- **TTL settings**: Modify `expireAfterWrite()` and `expireAfterAccess()`

### Monitoring Intervals
Update `application.yaml` for different monitoring frequencies:
- **High frequency**: 1m intervals for critical applications
- **Low frequency**: 15m intervals for less critical monitoring

## 🚨 Performance Testing

### Load Testing
```bash
# Install Apache Bench
sudo apt-get install apache2-utils

# Test performance
ab -n 1000 -c 10 http://localhost:8080/actuator/health
```

### Memory Profiling
```bash
# Enable JFR for detailed profiling
JAVA_OPTS="$JAVA_OPTS -XX:+FlightRecorder -XX:StartFlightRecording=duration=60s,filename=profile.jfr"
```

## 📝 Best Practices

1. **Monitor continuously**: Use the provided metrics endpoints
2. **Tune based on load**: Adjust settings based on actual usage patterns
3. **Regular updates**: Keep dependencies updated for performance improvements
4. **Resource monitoring**: Monitor CPU, memory, and network usage
5. **Cache optimization**: Monitor cache hit ratios and adjust accordingly

## 🔍 Troubleshooting

### High Memory Usage
- Check cache sizes and TTL settings
- Monitor garbage collection logs
- Adjust heap size based on actual usage

### Slow Response Times
- Check database connection pools
- Monitor cache hit ratios
- Review security filter performance

### High CPU Usage
- Enable JVM profiling
- Check for inefficient algorithms
- Monitor thread pool utilization