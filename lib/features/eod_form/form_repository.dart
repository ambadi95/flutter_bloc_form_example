class FormRepo{
  Future<void> submitEod()async{
    print('Submitting....');
    Future.delayed(const Duration(seconds: 3));
    print('Submitted');
  }
}