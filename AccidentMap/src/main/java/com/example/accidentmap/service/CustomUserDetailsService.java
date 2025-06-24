package com.example.accidentmap.service;

import com.example.accidentmap.dto.CustomSecurityUserDetails;
import com.example.accidentmap.entity.Member;
import com.example.accidentmap.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class CustomUserDetailsService implements UserDetailsService {

    private final MemberRepository memberRepository;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

        Member member = memberRepository.findByLoginId(username);

        if (member != null) {
            return new CustomSecurityUserDetails(member);
        }
        return null;
    }
}
