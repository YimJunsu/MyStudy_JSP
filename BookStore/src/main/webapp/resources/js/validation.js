function check(regExp, e, msg) {
    if (regExp.test(e.value)) return true;
    alert(msg);
    e.focus();
    return false;
}

function CheckAddBook() {
    var form = document.newBook;
    var bookId = form.bookId;
    var name = form.name;
    var unitPrice = form.unitPrice;
    var unitsInStock = form.unitsInStock;
    var description = form.description;

    if (!check(/^ISBN[0-9]{4,11}$/, bookId, "[도서 코드]\nISBN과 숫자를 조합하여 5~12자까지 입력하세요\n첫 글자는 반드시 ISBN로 시작하세요"))
        return false;

    if (name.value.length < 4 || name.value.length > 50) {
        alert("[도서명]\n최소 4자에서 최대 50자까지 입력하세요");
        name.focus();
        return false;
    }

    if (unitPrice.value.length == 0 || isNaN(unitPrice.value) || unitPrice.value < 0) {
        alert("[가격]\n0 이상 숫자만 입력하세요");
        unitPrice.focus();
        return false;
    }

    if (isNaN(unitsInStock.value)) {
        alert("[재고수]\n숫자만 입력하세요");
        unitsInStock.focus();
        return false;
    }

    if (description.value.length < 100) {
        alert("[상세설명]\n최소 100자 이상 입력하세요.");
        description.focus();
        return false;
    }

    form.submit();
    return true;
}
