// package com.cosmus.resonos.controller;

// import java.util.List;

// import org.springframework.beans.factory.annotation.Autowired;
// import org.springframework.security.access.prepost.PreAuthorize;
// import org.springframework.security.core.annotation.AuthenticationPrincipal;
// import org.springframework.stereotype.Controller;
// import org.springframework.ui.Model;
// import org.springframework.web.bind.annotation.GetMapping;
// import org.springframework.web.bind.annotation.ModelAttribute;
// import org.springframework.web.bind.annotation.PathVariable;
// import org.springframework.web.bind.annotation.PostMapping;
// import org.springframework.web.bind.annotation.RequestMapping;
// import org.springframework.web.util.UriComponentsBuilder;

// import com.cosmus.resonos.domain.CustomUser;
// import com.cosmus.resonos.domain.Pagination;
// import com.github.pagehelper.PageInfo;

// import lombok.extern.slf4j.Slf4j;




// @Slf4j
// @Controller
// @RequestMapping("/posts")
// public class PostController {

//     @Autowired private PostService postService;

//     @GetMapping("/list")
//     public String list(
//         Model model,
//         // @RequestParam(name = "page", defaultValue = "1") long page,
//         // @RequestParam(name = "size", defaultValue = "10") long size,
//         // @RequestParam(name = "count", defaultValue = "10") long count
//         Pagination pagination
//     ) throws Exception {
//         // Pagination pagination = new Pagination(page, size, count, 0);
//         List<Posts> list = postService.page(pagination);
//         model.addAttribute("pagination", pagination);
//         model.addAttribute("list", list);

//         // PageHelper 통한 페이징처리
//         int page = (int) pagination.getPage();
//         int size = (int)  pagination.getSize();
//         PageInfo<Posts> pageInfo = postService.page(page, size);
//         log.info("pageInfo : {}",pageInfo);
//         model.addAttribute("pageInfo", pageInfo);

//         // Uri 빌더
//         String pageUri = UriComponentsBuilder.fromPath("/posts/list")
//                                             // Pagination
//                                             //  .queryParam("size", pagination.getSize())
//                                             //  .queryParam("count", pagination.getCount())
//                                             // PageHelper
//                                              .queryParam("size", pageInfo.getSize())
//                                              .queryParam("count", pageInfo.getPageSize())
//                                              .build()
//                                              .toUriString();
//         model.addAttribute("pageUri", pageUri);
//         return "posts/list";

//     }



//     // 게시글 조회
//     @PreAuthorize("isAuthenticated()")      // 인증 체크
//     @GetMapping("/read/{id}")
//     public String read(@PathVariable("id") String id, Model model) throws Exception {
//         Posts post = postService.selectById(id);
//         model.addAttribute("post",  post);
//         return "posts/read";
//     }

//     // 게시글 등록
//     // @Secured("ROLE_USER")                // USER 권한 체크
//     // @PreAuthorize("hasRole('User')")     // USER 권한 체크
//     @PreAuthorize("isAuthenticated()")      // 인증 체크
//     @GetMapping("/create")
//     public String create(@ModelAttribute(value = "post") Posts post) {
//         return "posts/create";
//     }
    
//     // 게시글 등록 처리
//     @PreAuthorize("hasAnyRole('USER','ADMIN')")           // 2개 이상의 권한 체크
//     @PostMapping("/create")
//     public String createPost(Posts post, @AuthenticationPrincipal CustomUser customUser) throws Exception {
//         // 인증된 사용자의 no를 Posts의 userNo에 넣어줌 
//         post.setUserNo(customUser.getUser().getNo());
//         log.info("posts : {}", post);
//         boolean result = postService.insert(post);
//         if ( result )
//             return "redirect:/posts/list";
//         return "redirect:/posts/create?error=true";
//     }
    
//     /**
//      * 게시글 수정 
//      * @param id
//      * @param model
//      * @return
//      * @throws Exception
//      * 🟡🟡🟡 #p0, #p1 로 파라미터 인덱스를 지정하여 가져올 수 있다.
//      * 여기서는 요청 파라미터로 넘어온 id ➡ #p0
//      * "@빈이름" 형태로 특정 빈의 메소드를 호출할 수 있다.
//      * ➡ @PostService.isOwner()
//      */
//     @PreAuthorize("(hasRole('ADMIN')) or (#p0 != null and @PostService.isOwner(#p0, authentication.principal.user.no ))")
//     @GetMapping("/update/{id}")
//     public String update(@PathVariable("id") String id, Model model) throws Exception {
//         Posts post = postService.selectById(id);
//         model.addAttribute("post", post);
//         return "posts/update";
//     }
    
//     // 게시글 수정 처리
//     // 관리자 or 작성자 인증
//     @PreAuthorize("(hasRole('ADMIN')) or (#p0 != null and @PostService.isOwner(#p0, authentication.principal.user.no ))")
//     @PostMapping("/update")
//     public String updatePost(Posts post) throws Exception {
//         boolean result = postService.updateById(post);
//         if ( result )
//             return "redirect:/posts/list";
//         return "redirect:/posts/update?error=true";
//     }
    
//     // 게시글 삭제 처리
//     @PostMapping("/delete/{id}")
//     public String delete(@PathVariable("id") String id)  throws Exception{
//         boolean result = postService.deleteById(id);
//         if ( result )
//             return "redirect:/posts/list";
//         return "redirect:/posts/delete?error=true";
//     }
    
    
    
// }
