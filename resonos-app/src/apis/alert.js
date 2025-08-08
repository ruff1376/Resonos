import Swal from 'sweetalert2'
import withReactContent from 'sweetalert2-react-content'

export const MySwal = withReactContent(Swal)

// 기본 alert
export const alert = (title, text, icon, callback) => {
  MySwal.fire({
    title: title,
    text: text,
    icon: icon
  })
  .then( callback )   // alert 후 실행할 콜백함수
}

// confirm
export const confirm = (title, text, icon, callback) => {
  MySwal.fire({
    title: title,
    text: text,
    icon: icon,
    showCancelButton: true,    // [취소] 버튼 보이기
    cancelButtonColor: '#d33',
    cancelButtonText: '취소',
    confirmButtonColor: '#3085d6',
    confirmButtonText: '확인'
  })
  .then( callback )

}