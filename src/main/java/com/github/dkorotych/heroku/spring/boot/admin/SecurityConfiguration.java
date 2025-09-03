/**
 * Copyright 2022 Dmitry Korotych
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.github.dkorotych.heroku.spring.boot.admin;

import de.codecentric.boot.admin.server.config.AdminServerProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.server.reactive.ServerHttpResponse;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.web.reactive.EnableWebFluxSecurity;
import org.springframework.security.config.web.server.ServerHttpSecurity;
import org.springframework.security.web.server.SecurityWebFilterChain;

@Configuration(proxyBeanMethods = false)
@EnableWebFluxSecurity
public class SecurityConfiguration {
    
    @Bean
    SecurityWebFilterChain springSecurityFilterChain(ServerHttpSecurity http,
            AdminServerProperties adminServer) {
        return http
                .authorizeExchange(spec -> spec
                        // Static resources - no authentication needed
                        .pathMatchers(adminServer.path("/assets/**")).permitAll()
                        .pathMatchers("/actuator/health/**").permitAll()
                        .pathMatchers("/actuator/info").permitAll()
                        .pathMatchers("/actuator/metrics/**").permitAll()
                        .pathMatchers("/actuator/prometheus").permitAll()
                        // Login page - no authentication needed
                        .pathMatchers(adminServer.path("/login")).permitAll()
                        // All other requests require authentication
                        .anyExchange().authenticated())
                .formLogin(formLogin -> formLogin
                        .loginPage(adminServer.path("/login"))
                        .authenticationSuccessHandler((webFilterExchange, authentication) -> 
                                ServerHttpResponse.create().then())
                        .authenticationFailureHandler((webFilterExchange, exception) -> 
                                ServerHttpResponse.create().then()))
                .logout(logout -> logout
                        .logoutUrl(adminServer.path("/logout"))
                        .logoutSuccessHandler((webFilterExchange, authentication) -> 
                                ServerHttpResponse.create().then()))
                .httpBasic(Customizer.withDefaults())
                .csrf(ServerHttpSecurity.CsrfSpec::disable)
                .headers(headers -> headers
                        .frameOptions().disable()
                        .contentTypeOptions().disable())
                .build();
    }
}
