import React, { useState } from 'react';
import FormInput from '../first/FormInput';
import FormSelect from '../first/FormSelect';

const AddMemberForm = ({ onSubmit, onCancel }) => {
  const [formData, setFormData] = useState({
    username: '',
    nickname: '',
    email: '',
    password: '',
    profileImage: '',
    bio: '',
    isPro: 'false',
    enabled: 'true',
    auth: 'ROLE_USER',
    provider: '',
    providerId: '',
  });

  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData((prev) => ({ ...prev, [name]: value }));
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    onSubmit(formData); // 폼 제출 시 상위 컴포넌트 onSubmit 호출
  };

  // 취소버튼 클릭 시 onCancel 호출
  const handleCancel = () => {
    // 입력값 초기화(옵션)
    setFormData({
      username: '',
      nickname: '',
      email: '',
      password: '',
      profileImage: '',
      bio: '',
      isPro: 'false',
      enabled: 'true',
      auth: 'ROLE_USER',
      provider: '',
      providerId: '',
    });
    onCancel(); // 상위 컴포넌트에 폼 닫기 요청
  };

return (
  <div id="add-member-form-area" className="admin">
    <form className="resonos-card p-3 mb-4" onSubmit={handleSubmit}>
      <div className="row mb-3">
        <FormInput label="아이디(Username)" name="username" value={formData.username} onChange={handleChange} required />
        <FormInput label="닉네임" name="nickname" value={formData.nickname} onChange={handleChange} required />
      </div>
      <div className="row mb-3">
        <FormInput label="이메일" name="email" type="email" value={formData.email} onChange={handleChange} required />
        <FormInput label="비밀번호" name="password" type="password" value={formData.password} onChange={handleChange} required />
      </div>
      <div className="row mb-3">
        <FormInput label="프로필 이미지 URL" name="profileImage" value={formData.profileImage} onChange={handleChange} />
        <FormInput label="소개(Bio)" name="bio" value={formData.bio} onChange={handleChange} />
      </div>
      <div className="row mb-3">
        <FormSelect label="전문가 여부(isPro)" name="isPro" value={formData.isPro} onChange={handleChange}
          options={[{ value: 'false', label: '아니오' }, { value: 'true', label: '예' }]} />
        <FormSelect label="상태" name="enabled" value={formData.enabled} onChange={handleChange}
          options={[{ value: 'true', label: '정상' }, { value: 'false', label: '휴면' }]} />
        <FormSelect label="권한" name="auth" value={formData.auth} onChange={handleChange}
          options={[{ value: 'ROLE_USER', label: '일반' }, { value: 'ROLE_ADMIN', label: '운영자' }]} />
      </div>
      <div className="row mb-3">
        <FormInput label="Provider" name="provider" value={formData.provider} onChange={handleChange} />
        <FormInput label="Provider ID" name="providerId" value={formData.providerId} onChange={handleChange} />
      </div>
      <div className="text-end">
        <button type="submit" className="btn btn-gold btn-sm me-2">회원 등록</button>
        <button type="button" className="btn btn-outline-gold btn-sm" onClick={handleCancel}>취소</button>
      </div>
    </form>
  </div>
);

};

export default AddMemberForm;
